open Support.Utils
open Cif
open Types
open Type_check

(* Add a variable->type binding to the type info.
 * If a variable with a type is encounted,
 * make sure it has the same type. *)
let add_type_info (v : var) (t : ty) (env : ty_env) : ty_env =
  match Env.find_opt v env with
    | None -> Env.add v t env
    | Some t' ->
      if not (ty_equal t t') then
        failwithf
          "variable [%s] type conflict: was [%s] but is now [%s]"
          v (string_of_ty t) (string_of_ty t')
      else
        env

let type_check_atm (env : ty_env) (a : atm) : ty =
  match a with
    | Bool _ -> Boolean
    | Int _  -> Integer
    | Var v  ->
      begin
        match Env.find_opt v env with
          | None -> ty_err_simple ("unbound variable: " ^ v)
          | Some t -> t
      end

let type_check_exp (env : ty_env) (e : exp) : ty =
  match e with
    | Atm a -> type_check_atm env a
    | Prim (op, atms) ->
      let arg_tys = List.map (type_check_atm env) atms in
        type_check_op op arg_tys

let type_check_stmt (env : ty_env) (s : stmt) : ty_env =
  match s with
    | Assign (v, e) ->
      let e_ty = type_check_exp env e in
        add_type_info v e_ty env

(* Type check a tail.
 * Add the new type information to the type environment that is returned. *)
let rec type_check_tail (env : ty_env) (t : tail) : ty_env =
  match t with
    | Return e -> 
      begin
        match type_check_exp env e with
          | Integer -> env
          | t -> ty_err "return expression" ~expected:Integer ~got:t
      end
    | Goto _ -> env
    | Seq (s, t) ->
      let env' = type_check_stmt env s in
        type_check_tail env' t
    | IfStmt { op; arg1; arg2; _ } ->
      begin
        match type_check_exp env (Prim ((op :> core_op), [arg1; arg2])) with
          | Boolean -> env
          | Integer -> 
            ty_err "if test expression" ~expected:Boolean ~got:Integer
      end

(* Make sure all variables have types. *)
let check_vars (vlst : var list) (env : ty_env) : unit =
  List.iter
    (fun v ->
       if not (Env.mem v env) then
         let msg =
           Printf.sprintf
             "check_vars: variable (%s) has no type binding" v
         in
           ty_err_simple msg
       else
         ())
    vlst

(* Compute the type environment by considering the tails in the
 * order in which they're encountered.
 * This assumes that the list has been topologically sorted. *)
let compute_ty_env (ts : tail list) : ty_env =
  List.fold_left type_check_tail Env.empty ts

let type_check (CProgram (Info _, lts) as p) =
  let env  = 
    lts |> tsort_lts |> List.split |> snd |> compute_ty_env
  in
  let vars = get_vars p in
  let _ = check_vars vars env in
  (* Throw away the old (empty) `Info` field, which is empty.
   * Replace it with the type information for each variable. *)
  let locals_types = Env.bindings env in
  let info = Info { locals_types } in
    CProgram (info, lts)
