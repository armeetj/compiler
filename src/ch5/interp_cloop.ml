open Types
open Interp
open Cloop

(* NOTE:
 * The environment now is NOT a mapping between names and value refs,
 * but between names and values.
 * That's because the functionality of `let` and `set!` gets folded
 * into a single `Assign` statement, which does both things
 * (adds a binding if it's not there, and mutates a binding if it is there).
 * Note that once registers are selected, the location is conceptually
 * "always there", so there is no need to "create" it. *)

let interp_atm (env : value Env.t) (a : atm) : value =
  match a with
    | Void   -> VoidV
    | Bool b -> BoolV b
    | Int  i -> IntV i
    | Var  v ->
      Env.find_or_fail v env
        ~err_msg: (Printf.sprintf "interp_atm: unbound name: %s" v)

let interp_exp (env : value Env.t) (e : exp) : value =
  match e with
    | Atm a -> interp_atm env a
    | Prim (op, args) -> 
      let args' = List.map (interp_atm env) args in
        interp_core_op op args'

let interp_stmt (env : value Env.t) (s : stmt) : value Env.t =
  match s with
    | Assign (v, e) -> Env.add v (interp_exp env e) env
    | PrimS (op, args) -> 
      let args' = List.map (interp_atm env) args in
        begin
          ignore (interp_stmt_op op args');
          env
        end

let rec interp_tail
    (lmap : tail LabelMap.t)
    (env  : value Env.t)
    (t    : tail)
          : (value Env.t * value) =
  match t with
    | Return e -> (env, interp_exp env e)
    | Seq (stmt, t') ->
      let env' = interp_stmt env stmt in
        interp_tail lmap env' t'
    | Goto lbl -> interp_lbl lmap env lbl
    | IfStmt { op; arg1; arg2; jump_then; jump_else } ->
      let arg1' = interp_atm env arg1 in
      let arg2' = interp_atm env arg2 in
        match interp_cmp_op op [arg1'; arg2'] with
          | BoolV b ->
            let lbl = if b then jump_then else jump_else in
              interp_lbl lmap env lbl
          | _ -> failwith "interp_tail: if: wrong type"

and interp_lbl
    (lmap : tail LabelMap.t)
    (env  : value Env.t)
    (lbl  : label)
          : (value Env.t * value) =
  let t' =
    LabelMap.find_or_fail lbl lmap
      ~err_msg: ("interp_lbl: no target for label: " ^ string_of_label lbl)
  in
    interp_tail lmap env t'
            
let interp (CProgram (_, labeled_tails)) : int =
  let lmap = LabelMap.of_list labeled_tails in
  let (_, result) = interp_lbl lmap Env.empty (Label "start") in
    expect_int ~err_msg:"interp: return value" result
