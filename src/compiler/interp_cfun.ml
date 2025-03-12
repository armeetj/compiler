open Support.Utils
open Types
open Type_check
open Interp
open Interp_utils
open Cfun

(* NOTES:
   The environment now is NOT a mapping between names and value refs,
   but between names and values.
   That's because the functionality of `let` and `set!` gets folded
   into a single `Assign` statement, which does both things
   (adds a binding if it's not there, and mutates a binding if it is there).
   Note that once registers are selected, the location is conceptually
   "always there", so there is no need to "create" it.

   Since environments are part of functions,
   and functions are one kind of value,
   we have to redefine the `value` type.

   Also, since we are not using the "function-on-environment" style
   for the function body, we have to redefine that too.
 *)

type value =
  [simple_value | `VecV of value array | `FunV of fun_value * env_t option ref]

and fun_value =
  { vargs : (var * ty) list
  ; vret : ty (* return type *)
  ; vbody : (label * tail) list }

and env_t = value Env.t

(* ----------------------------------------------------------------------  
 * Utility functions.
 * ---------------------------------------------------------------------- *)

(* Generate an "uninitialized" default value for any type.
 * The actual value doesn't matter. *)
let rec default_val (t : ty) : value =
  match t with
  | Unit -> `VoidV
  | Boolean -> `BoolV false
  | Integer -> `IntV 0
  | Vector ts -> `VecV (Array.map default_val ts)
  | Function (ts, t') ->
    let vars =
      (* dummy formal variables: "_0", "_1" etc. *)
      List.map (fun i -> "_" ^ string_of_int i) (range 0 (List.length ts))
    in
    let vargs = List.combine vars ts in
    let vret = t' in
    let vbody = [] in
    let env = ref None in
    `FunV ({vargs; vret; vbody}, env)

(* Convert a `fun_contents` record into a `fun_value` record. *)
let fun_value_of_fun_contents (fc : fun_contents) : fun_value =
  let {args; ret; body; _} = fc in
  {vargs = args; vret = ret; vbody = body}

(* ----------------------------------------------------------------------  
 * Definitional interpreter.
 * ---------------------------------------------------------------------- *)

(* NOTE:
   We don't extend the interpreters for the earlier languages
   because the Cfun language is so different from those languages
   that extending it from them wouldn't be significantly shorter.
   Also, the value/env types have changed, which makes extension much harder.
   It's also the last interpreter, so it won't need to be extended,
   which is why we don't write it in the function-on-environments style.
   This means there is a lot of code duplication
   from the previous interpreters.
   There are ways of removing this duplication,
   but they make the types more complex,
   and IMO the added complexity isn't worth it. *)

let interp_atm (env : env_t) (a : atm) : value =
  match a with
  | Void -> `VoidV
  | Bool b -> `BoolV b
  | Int i -> `IntV i
  | Var v ->
    Env.find_or_fail v env
      ~err_msg:(Printf.sprintf "interp_atm: unbound name: %s" v)

let rec interp_exp (env : env_t) (e : exp) : value =
  match e with
  | Atm a -> interp_atm env a
  | Prim (op, args) ->
    let args' = List.map (interp_atm env) args in
    (interp_core_op_simple op args' :> value)
  | Allocate (n, Vector ts) ->
    (* Return an "uninitialized" value of a vector type. *)
    if Array.length ts <> n then
      failwithf "interp_exp: malformed `Allocate` case"
    else
      (* Compute the allocation size in bytes, which is (8 * (n + 1)) i.e.
             8 bytes for each slot + 8 bytes for the tag.
             Allocate the memory and return a vector of uninitialized values. *)
      let size = 8 * (n + 1) in
      allocate size ;
      `VecV (Array.map default_val ts)
  | Allocate (_, t) ->
    failwithf "interp_exp: can't allocate type (%s)" (string_of_ty t)
  | GlobalVal v -> (
    match v with
    | "free_ptr" -> `IntV !free_ptr
    | "fromspace_end" -> `IntV !fromspace_end
    | _ -> failwithf "unknown global variable (%s)" v )
  | VecLen a -> (
    match interp_atm env a with
    | `VecV vs -> `IntV (Array.length vs)
    | _ -> failwith "interp_exp: vector-length : wrong type" )
  | VecRef (a, i) -> (
    match interp_atm env a with
    | `VecV vs ->
      if i >= 0 && i < Array.length vs then vs.(i)
      else failwith "interp_exp: vector-ref : index out of range"
    | _ -> failwith "interp_exp: vector-ref : wrong types" )
  | VecSet (a1, i, a2) -> (
    match interp_atm env a1 with
    | `VecV vs ->
      if i >= 0 && i < Array.length vs then (
        let v = interp_atm env a2 in
        vs.(i) <- v ;
        `VoidV )
      else failwith "interp_exp: vector-set! : index out of range"
    | _ -> failwith "interp_exp: vector-set! : wrong types" )
  | FunRef (Label v, _) ->
    (* NOTE:
           In this interpreter,
           we are mixing function labels and variable names.
           In the final code, these will be distinct. *)
    Env.find_or_fail v env
      ~err_msg:(Printf.sprintf "interp_exp: unbound function name: %s" v)
  | Call (atm, atms) -> (
    match interp_atm env atm with
    | `FunV (f, e) -> (
      match !e with
      | None -> failwith "interp_exp: function value has no environment"
      | Some env' ->
        let args = List.map (interp_atm env) atms in
        apply f env' args )
    | v ->
      failwithf "interp_exp: applied non-function: (%s)" (string_of_value v) )

and apply f env args =
  let vars = List.map fst f.vargs in
  let arglist =
    try List.combine vars args with
    | Invalid_argument _ ->
      (* list length mismatch *)
      failwithf "apply: expected (%d) arguments but got (%d)" (List.length vars)
        (List.length args)
  in
  (* Create the function body environment, including the bindings
     between arguments and formal parameters.
     The environment binds names to value refs, so we wrap each value
     in a `ref`. *)
  let env' = List.fold_left (fun e (v, a) -> Env.add v a e) env arglist in
  interp_body env' f.vbody

and interp_stmt (env : env_t) (s : stmt) : env_t =
  match s with
  | Assign (v, e) -> Env.add v (interp_exp env e) env
  | PrimS (op, args) ->
    let args' = List.map (interp_atm env) args in
    ignore (interp_stmt_op_simple op args' :> value) ;
    env
  | CallS (atm, atms) -> (
    match interp_atm env atm with
    | `FunV (f, e) -> (
      match !e with
      | None -> failwith "interp_stmt: function value has no environment"
      | Some env' ->
        let args = List.map (interp_atm env) atms in
        ignore (apply f env' args) ;
        env )
    | v ->
      failwithf "interp_exp: applied non-function: (%s)" (string_of_value v) )
  | Collect n -> collect n ; env
  | VecSetS (a1, i, a2) -> (
    match interp_atm env a1 with
    | `VecV vs ->
      if i >= 0 && i < Array.length vs then (
        let v = interp_atm env a2 in
        vs.(i) <- v ;
        env )
      else failwith "interp_stmt: vector-set! : index out of range"
    | _ -> failwith "interp_stmt: vector-set! : wrong types" )

and interp_tail (lmap : tail LabelMap.t) (env : env_t) (t : tail) : value =
  match t with
  | Return e -> interp_exp env e
  | TailCall (atm, atms) -> (
    match interp_atm env atm with
    | `FunV (f, e) -> (
      match !e with
      | None -> failwith "interp_tail: function value has no environment"
      | Some env' ->
        let args = List.map (interp_atm env) atms in
        apply f env' args )
    | v ->
      failwithf "interp_tail: applied non-function: (%s)" (string_of_value v) )
  | Seq (stmt, t') ->
    let env' = interp_stmt env stmt in
    interp_tail lmap env' t'
  | Goto lbl -> interp_lbl lmap env lbl
  | IfStmt {op; arg1; arg2; jump_then; jump_else} -> (
    let arg1' = interp_atm env arg1 in
    let arg2' = interp_atm env arg2 in
    match (interp_cmp_op_simple op [arg1'; arg2'] :> value) with
    | `BoolV b ->
      let lbl = if b then jump_then else jump_else in
      interp_lbl lmap env lbl
    | _ -> failwith "interp_tail: if: wrong type" )

and interp_lbl (lmap : tail LabelMap.t) (env : env_t) (lbl : label) : value =
  let t' =
    LabelMap.find_or_fail lbl lmap
      ~err_msg:("interp_lbl: no target for label: " ^ string_of_label lbl)
  in
  interp_tail lmap env t'

and interp_body (env : env_t) (body : (label * tail) list) : value =
  let lmap = LabelMap.of_list body in
  (* NOTE: Each function will have its own "start" label. *)
  interp_lbl lmap env (Label "start")

let interp (CProgram defs) : int =
  let _ = init_gc_globals () in
  let defs' =
    List.map
      (fun (Def (name, fcont)) -> (name, fun_value_of_fun_contents fcont))
      defs
  in
  let def_names = List.map (fun (Label lbl, _) -> lbl) defs' in
  (* Create function values from defs, using dummy environments. *)
  let env' =
    List.fold_left
      (fun e (Label lbl, f) -> Env.add lbl (`FunV (f, ref None)) e)
      Env.empty defs'
  in
  (* Update the function environments to include all defined functions. *)
  let _ =
    List.iter
      (fun name ->
        let fun_ref = Env.find name env' in
        match fun_ref with
        | `FunV (_, e) -> e := Some env'
        | _ ->
          failwithf "interp: non-function value bound to function (%s)" name )
      def_names
  in
  (* Get the body of the "main" function and execute it. *)
  match Env.find_opt "main" env' with
  | None -> failwith "no `main` function"
  | Some fun_ref -> (
    match fun_ref with
    | `FunV ({vbody; _}, env_optref) -> (
      match !env_optref with
      | None -> failwith "interp: `main` function has no environment"
      | Some env'' ->
        let v = interp_body env'' vbody in
        expect_int ~err_msg:"interp: return value" ~to_string:string_of_value v
      )
    | _ -> failwith "interp: non-function value bound to function (main)" )
