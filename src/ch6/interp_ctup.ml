open Support.Utils
open Types
open Type_check
open Interp
open Interp_utils
open Ctup

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
  | Void -> VoidV
  | Bool b -> BoolV b
  | Int i -> IntV i
  | Var v ->
    Env.find_or_fail v env
      ~err_msg:(Printf.sprintf "interp_atm: unbound name: %s" v)

let interp_exp (env : value Env.t) (e : exp) : value =
  match e with
  | Atm a -> interp_atm env a
  | Prim (op, args) ->
    let args' = List.map (interp_atm env) args in
    interp_core_op op args'
  | Allocate (n, Vector ts) ->
    (* Return an "uninitialized" value of a vector type. *)
    if Array.length ts <> n then
      failwithf "interp_exp: malformed `Allocate` case"
    else
      (* Compute the allocation size in bytes, which is (8 * (n + 1)) i.e.
       * 8 bytes for each slot + 8 bytes for the tag.
       * Allocate the memory and return a vector of uninitialized values. *)
      let size = 8 * (n + 1) in
      allocate size ;
      VecV (Array.map default_val ts)
  | Allocate (_, t) ->
    failwithf "interp_exp: can't allocate type (%s)" (string_of_ty t)
  | GlobalVal v -> (
    match v with
    | "free_ptr" -> IntV !free_ptr
    | "fromspace_end" -> IntV !fromspace_end
    | _ -> failwithf "unknown global variable (%s)" v )
  | VecLen a -> (
    match interp_atm env a with
    | VecV vs -> IntV (Array.length vs)
    | _ -> failwith "interp_exp: vector-length : wrong type" )
  | VecRef (a, i) -> (
    match interp_atm env a with
    | VecV vs ->
      if i >= 0 && i < Array.length vs then vs.(i)
      else failwith "interp_exp: vector-ref : index out of range"
    | _ -> failwith "interp_exp: vector-ref : wrong types" )
  | VecSet (a1, i, a2) -> (
    match interp_atm env a1 with
    | VecV vs ->
      if i >= 0 && i < Array.length vs then (
        let v = interp_atm env a2 in
        vs.(i) <- v ;
        VoidV )
      else failwith "interp_exp: vector-set! : index out of range"
    | _ -> failwith "interp_exp: vector-set! : wrong types" )

let interp_stmt (env : value Env.t) (s : stmt) : value Env.t =
  match s with
  | Assign (v, e) -> Env.add v (interp_exp env e) env
  | PrimS (op, args) ->
    let args' = List.map (interp_atm env) args in
    ignore (interp_stmt_op op args') ;
    env
  | Collect n -> collect n ; env
  | VecSetS (a1, i, a2) -> (
    match interp_atm env a1 with
    | VecV vs ->
      if i >= 0 && i < Array.length vs then (
        let v = interp_atm env a2 in
        vs.(i) <- v ;
        env )
      else failwith "interp_stmt: vector-set! : index out of range"
    | _ -> failwith "interp_stmt: vector-set! : wrong types" )

let rec interp_tail (lmap : tail LabelMap.t) (env : value Env.t) (t : tail) :
  value Env.t * value =
  match t with
  | Return e -> (env, interp_exp env e)
  | Seq (stmt, t') ->
    let env' = interp_stmt env stmt in
    interp_tail lmap env' t'
  | Goto lbl -> interp_lbl lmap env lbl
  | IfStmt {op; arg1; arg2; jump_then; jump_else} -> (
    let arg1' = interp_atm env arg1 in
    let arg2' = interp_atm env arg2 in
    match interp_cmp_op op [arg1'; arg2'] with
    | BoolV b ->
      let lbl = if b then jump_then else jump_else in
      interp_lbl lmap env lbl
    | _ -> failwith "interp_tail: if: wrong type" )

and interp_lbl (lmap : tail LabelMap.t) (env : value Env.t) (lbl : label) :
  value Env.t * value =
  let t' =
    LabelMap.find_or_fail lbl lmap
      ~err_msg:("interp_lbl: no target for label: " ^ string_of_label lbl)
  in
  interp_tail lmap env t'

let interp (CProgram (_, labeled_tails)) : int =
  let _ = init_gc_globals () in
  let lmap = LabelMap.of_list labeled_tails in
  let _, result = interp_lbl lmap Env.empty (Label "start") in
  expect_int ~err_msg:"interp: return value" result
