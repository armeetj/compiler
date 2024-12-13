open Support.Utils
open Types
open Cfun
module L = Lfun_ref_mon

(* Variable to hold gensym function. *)
let fresh = ref (make_gensym ())

(* Variable to hold labeled blocks for a single function. *)
let basic_blocks : tail LabelMap.t ref = ref LabelMap.empty

(* Dummy variables should always have the prefix "_.". *)
let is_dummy_var v = String.sub v 0 2 = "_."

let convert_atom (a : L.atm) : atm =
  match a with
  | L.Bool b -> Bool b
  | L.Var v -> Var v
  | L.Int i -> Int i
  | L.Void -> Void

let convert_exp (e : L.exp) : exp =
  match e with
  | L.Atm a -> Atm (convert_atom a)
  | L.Prim (op, exp_lst) -> Prim (op, List.map convert_atom exp_lst)
  (* GlobalVal and Allocate only in convert_exp *)
  | L.Allocate (i, ty) -> Allocate (i, ty)
  | L.GlobalVal v -> GlobalVal v
  | L.VecLen a -> VecLen (convert_atom a)
  | L.VecRef (a, idx) -> VecRef (convert_atom a, idx)
  | L.VecSet (a1, idx, a2) -> VecSet (convert_atom a1, idx, convert_atom a2)
  | L.FunRef (l, arity) -> FunRef (l, arity)
  | L.Apply (f, args) -> Call (convert_atom f, List.map convert_atom args)
  | _ -> failwith "ec:convert_exp invalid type passed to convert_exp"

(* Convert expressions which are the binding expression of a `let` expression
 * (i.e. in `(let (var <exp1>) <exp2>)` the binding expression is `<exp1>`).
 * These are ultimately converted to assignments.
 * The `tail` is the continuation (what to do after the binding). *)
let rec explicate_assign (e : L.exp) (v : var) (tl : tail) : tail =
  match e with
  | L.Let (v_in, binding_exp, body_exp) ->
    explicate_assign binding_exp v_in (explicate_assign body_exp v tl)
  | L.If (cond, then_exp, else_exp) ->
    let tail_block = Goto (create_block tl) in
    let then_tl = explicate_assign then_exp v tail_block in
    let else_tl = explicate_assign else_exp v tail_block in
    explicate_pred cond then_tl else_tl
  (* all effect expressions first -> final exp *)
  | L.Begin (effect_exps, final_exp) ->
    (*  first assign (v = final_exp, tl) *)
    let aux = explicate_assign final_exp v tl in
    (* then fold_right all side effects *)
    List.fold_right (fun e acc -> explicate_effect e acc) effect_exps aux
  | L.SetBang (v_in, exp) ->
    let aux = explicate_assign exp v_in tl in
    explicate_assign (Atm Void) v aux
  | L.Collect i -> Seq (Collect i, tl)
  | _ -> Seq (Assign (v, convert_exp e), tl)

(* Convert `if` expressions.
 * `e` is the condition part of the expression (evaluating to boolean).
 * The `then_tl` and `else_tl` are the two possible continuations. *)
and explicate_pred (e : L.exp) (then_tl : tail) (else_tl : tail) : tail =
  match e with
  | L.Atm a -> (
    match a with
    | L.Bool true -> then_tl
    | L.Bool false -> else_tl
    | L.Int _
     |L.Void ->
      failwith
        "cond can't be an Int or Void, this shouldn't have made it past the \
         type checker"
    | L.Var v ->
      let then_block = create_block then_tl in
      let else_block = create_block else_tl in
      IfStmt
        { op = `Eq
        ; arg1 = Var v
        ; arg2 = Bool true
        ; jump_then = then_block
        ; jump_else = else_block } )
  (* a1 cmp a2 *)
  | L.Prim ((#cmp_op as op), [a1; a2]) ->
    let then_block = create_block then_tl in
    let else_block = create_block else_tl in
    IfStmt
      { op
      ; arg1 = convert_atom a1
      ; arg2 = convert_atom a2
      ; jump_then = then_block
      ; jump_else = else_block }
  (* Not a *)
  | L.Prim (`Not, [a]) -> (
    match a with
    | L.Bool true -> else_tl
    | L.Bool false -> then_tl
    | L.Int _
     |L.Void ->
      failwith
        "cond can't be an Int, this shouldn't have made it past the type \
         checker"
    | L.Var v ->
      let then_block = create_block then_tl in
      let else_block = create_block else_tl in
      IfStmt
        { op = `Eq
        ; arg1 = Var v
        ; arg2 = Bool false
        ; jump_then = then_block
        ; jump_else = else_block } )
  | L.Let (v, binding_exp, body_exp) ->
    explicate_assign binding_exp v (explicate_pred body_exp then_tl else_tl)
  | L.If (cond, then_exp, else_exp) ->
    let then_block = create_block then_tl in
    let else_block = create_block else_tl in
    let tail_true =
      explicate_pred then_exp (Goto then_block) (Goto else_block)
    in
    let tail_false =
      explicate_pred else_exp (Goto then_block) (Goto else_block)
    in
    explicate_pred cond tail_true tail_false
  | L.While _ -> failwith "ec:explicate_pred invalid exp type : While"
  | L.SetBang _ -> failwith "ec:explicate_pred invalid exp type : SetBang"
  | L.Begin (effect_exps, final_exp) ->
    let aux = explicate_pred final_exp then_tl else_tl in
    List.fold_right explicate_effect effect_exps aux
  | L.VecRef (v, i) ->
    let new_name = !fresh ~base:"vecref" ~sep:"_" in
    let if_tl = explicate_pred (Atm (Var new_name)) then_tl else_tl in
    explicate_assign (VecRef (v, i)) new_name if_tl
  | L.VecSet _ -> failwith "ec:explicate_pred VecSet cannot return a bool"
  | L.Apply (f, args) ->
    let new_name = !fresh ~base:"apply" ~sep:"_" in
    let if_tl = explicate_pred (Atm (Var new_name)) then_tl else_tl in
    explicate_assign (Apply (f, args)) new_name if_tl
  | _ ->
    failwith
      "[ec:explicate_pred] invalid cond exp type (must be a boolean resolvable \
       exp)"

(* Convert expressions in effect position.
 * Effect position includes:
 * - the expressions before the last expression in a `begin` expression
 * - the body expressions in a `while` loop
 * These are expressions that are only evaluated for their side effects.
 * Pure expressions in effect position are discarded,
 * since they can't have any effect. *)
and explicate_effect (e : L.exp) (tl : tail) : tail =
  match e with
  | L.Atm _ -> tl
  | L.Prim (((`Read | `Print) as op), a_lst) ->
    let atm_lst = List.map convert_atom a_lst in
    Seq (PrimS (op, atm_lst), tl)
  | L.SetBang (v, e) -> explicate_assign e v tl
  | L.Begin (effect_exps, final_exp) ->
    List.fold_right explicate_effect effect_exps (explicate_effect final_exp tl)
  | L.If (cond_exp, then_exp, else_exp) ->
    let aux = create_block tl in
    let then_tl = explicate_effect then_exp (Goto aux) in
    let else_tl = explicate_effect else_exp (Goto aux) in
    explicate_pred cond_exp then_tl else_tl
  | L.While (cond_exp, body_exp) ->
    let loop_label = Label (!fresh ~base:"loop" ~sep:"_") in
    let body_aux = explicate_effect body_exp (Goto loop_label) in
    (* "if equiv form has to be processed be explicate_pred returning a tail which constitutes a basic_block" *)
    let basic_block = explicate_pred cond_exp body_aux tl in
    let () =
      basic_blocks := LabelMap.add loop_label basic_block !basic_blocks
    in
    Goto loop_label
  | L.Let (v, bind_exp, body_exp) ->
    let tl = explicate_effect body_exp tl in
    explicate_assign bind_exp v tl
  | L.Collect i -> Seq (Collect i, tl)
  | L.Allocate _
   |L.GlobalVal _ ->
    failwith
      "ec:explicate_effect neither Allocate & GlobalVal should be processed \
       for effects alone"
  | L.VecLen _
   |L.VecRef _ ->
    failwith
      "ec:explicate_effect neither VecLen nor VecRef have any side-effects"
  | L.VecSet (a1, i, a2) ->
    let a1 = convert_atom a1 in
    let a2 = convert_atom a2 in
    Seq (VecSetS (a1, i, a2), tl)
  | L.Apply (f, args) ->
    Seq (CallS (convert_atom f, List.map convert_atom args), tl)
  | _ ->
    failwith
      "ec:explicate_effect unsupported exp type passed to explicate_effect"

(* Convert expressions in tail position.
 * This includes:
 * 1) any top-level expression
 * 2) any expression at the end of a larger expression
 *    that will be evaluated to give the result of the entire expression
 * Examples of (2):
 * - the body of a `let`
 * - the then/else clauses of an `if`
 * - the last expression of a `begin` *)
and explicate_tail (e : L.exp) : tail =
  match e with
  | L.While _ ->
    let tl = Return (Atm Void) in
    explicate_effect e tl
  | L.Begin (effect_exps, final_exp) ->
    let tl = explicate_tail final_exp in
    List.fold_right explicate_effect effect_exps tl
  | L.SetBang (v, e) ->
    let tl = Return (Atm Void) in
    explicate_assign e v tl
  | L.If (cond, then_exp, else_exp) ->
    let aux_else = explicate_tail else_exp in
    let aux_then = explicate_tail then_exp in
    explicate_pred cond aux_then aux_else
  | L.Let (v, binding_exp, body_exp) ->
    let aux = explicate_tail body_exp in
    explicate_assign binding_exp v aux
  | L.Collect _ ->
    failwith "ec:explicate_tail Collect should never be in tail position"
  | L.Allocate _
   |L.GlobalVal _ ->
    failwith
      "ec:explicate_tail Allocate & GlobalVal should only be handled in \
       convert_exp"
  | L.Apply (f, args) -> TailCall (convert_atom f, List.map convert_atom args)
  | _ -> Return (convert_exp e)

(* Create a block from a tail.
 * Return a "goto" label to the block. *)
and create_block (tl : tail) : label =
  match tl with
  | Goto lbl -> lbl
  | Return _
   |Seq _
   |TailCall _
   |IfStmt _ ->
    let name = !fresh ~base:"block" ~sep:"_" in
    let lbl = Label name in
    basic_blocks := LabelMap.add lbl tl !basic_blocks ;
    lbl

let explicate_defs (d : L.def) : def =
  (* Initialize variable to hold labeled blocks to an empty map. *)
  let _ = basic_blocks := LabelMap.empty in
  let (L.Def (lbl, f)) = d in
  let L.{args; ret; body} = f in
  let t = explicate_tail body in
  (* The `locals` field is empty here;
   * it will be filled in by the type checker. *)
  let locals = [] in
  (* Collect the labeled blocks to make the function body. *)
  let lts = [(Label "start", t)] @ LabelMap.bindings !basic_blocks in
  let fc = {args; ret; locals; body = lts} in
  Def (lbl, fc)

let explicate_control (prog : L.program) : program =
  let (L.Program ds) = prog in
  let _ = fresh := make_gensym () in
  CProgram (List.map explicate_defs ds)
