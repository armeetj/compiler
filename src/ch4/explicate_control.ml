open Support.Utils
open Types
open Cif
module L = Lif_mon

(* Variable to hold gensym function. *)
let fresh = ref (make_gensym ())

(* Variable to hold labeled blocks. *)
let basic_blocks = ref LabelMap.empty

let convert_atom (a : L.atm) : atm =
  match a with L.Bool b -> Bool b | L.Var v -> Var v | L.Int i -> Int i

let convert_exp (e : L.exp) : exp =
  match e with
  | L.Atm a ->
      Atm (convert_atom a)
  | L.Prim (op, atm_lst) ->
      Prim (op, List.map convert_atom atm_lst)
  | L.If (_, _, _) ->
      failwith "[ec:convert_exp] If should never be passed to convert_exp"
  | L.Let (_, _, _) ->
      failwith "[ec:convert_exp] Let should never be passed to convert_exp"

(* Convert expressions which are the binding expression of a `let` expression
 * (i.e. in `(let (var <exp1>) <exp2>)` the binding expression is `<exp1>`).
 * These are ultimately converted to assignments.
 * The `tail` is the continuation (what to do after the binding). *)
let rec explicate_assign (e : L.exp) (v : var) (tl : tail) : tail =
  match e with
  | L.Let (v_in, binding_exp, body_exp) ->
      explicate_assign binding_exp v_in (explicate_assign body_exp v tl)
  | L.If (cond, then_exp, else_exp) ->
      let tail_block = create_block tl in
      explicate_pred cond
        (explicate_assign then_exp v (Goto tail_block))
        (explicate_assign else_exp v (Goto tail_block))
  | _ ->
      Seq (Assign (v, convert_exp e), tl)

(* Convert `if` expressions.
 * `e` is the condition part of the expression (evaluating to boolean).
 * The `then_tl` and `else_tl` are the two possible continuations. *)
and explicate_pred (e : L.exp) (then_tl : tail) (else_tl : tail) : tail =
  match e with
  | L.Atm a -> (
    match a with
    | L.Bool true ->
        then_tl
    | L.Bool false ->
        else_tl
    | L.Int _ ->
        failwith
          "cond can't be an Int, this shouldn't have made it past the type \
           checker"
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
  | L.Prim (_, [_; _]) ->
      failwith "explicate_pred: primitive of if must be a cmp_op"
  (* Not a *)
  | L.Prim (`Not, [a]) -> (
    match a with
    | L.Bool true ->
        else_tl
    | L.Bool false ->
        then_tl
    | L.Int _ ->
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
  | _ ->
      failwith "invalid cond exp type (must be a boolean resolvable exp)"

(* Convert expressions in tail position.
 * This includes:
 * 1) any top-level expression
 * 2) any expression at the end of a larger expression
 *    that will be evaluated to give the result of the entire expression
 * Examples of (2):
 * - the body of a `let`
 * - the then/else clauses of an `if`
 *)
and explicate_tail (e : L.exp) : tail =
  match e with
  | L.If (cond, then_exp, else_exp) ->
      explicate_pred cond (explicate_tail then_exp) (explicate_tail else_exp)
  | L.Let (v, binding_exp, body_exp) ->
      explicate_assign binding_exp v (explicate_tail body_exp)
  | _ ->
      Return (convert_exp e)

(* Create a block from a tail.
 * Return a "goto" label to the block. *)
and create_block (tl : tail) : label =
  match tl with
  | Goto lbl ->
      lbl
  | Return _ | Seq _ | IfStmt _ ->
      let name = !fresh ~base:"block" ~sep:"_" in
      let lbl = Label name in
      basic_blocks := LabelMap.add lbl tl !basic_blocks ;
      lbl

let init_globals () =
  fresh := make_gensym () ;
  basic_blocks := LabelMap.empty

let explicate_control (L.Program e) =
  let _ = init_globals () in
  let t = explicate_tail e in
  (* The info field is empty here;
   * it will be filled in by the type checker. *)
  let info = Info {locals_types = []} in
  let lts = [(Label "start", t)] @ LabelMap.bindings !basic_blocks in
  let lts' = tsort_lts lts in
  CProgram (info, lts')
