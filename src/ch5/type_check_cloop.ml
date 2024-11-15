open Cloop
open Types
open Type_check

(* Boolean value which is `true` if all names have been assigned types. *)
let all_assigned = ref true

(* Add a variable->type binding to the type info.
 * If a variable with a type is encounted,
 * make sure it has the same type. *)
let add_type_info (v : var) (t : ty) (env : ty_env_t) : ty_env_t =
  match Env.find_opt v env with
    | None -> Env.add v t env
    | Some t' ->
      if not (ty_equal t t') then
        ty_err_simple @@
          Printf.sprintf
            "variable [%s] type conflict: was [%s] but is now [%s]"
            v (string_of_ty t) (string_of_ty t')
      else
        env

let type_check_atm (env : ty_env_t) (a : atm) : ty option =
  match a with
    | Void   -> Some Unit
    | Bool _ -> Some Boolean
    | Int _  -> Some Integer
    | Var v  ->
      begin
        match Env.find_opt v env with
          | None -> (all_assigned := false; None)
          | Some t -> Some t
      end

let type_check_exp (env : ty_env_t) (e : exp) : ty option =
  match e with
    | Atm a -> type_check_atm env a
    | Prim (op, atms) ->
      let arg_tys = List.filter_map (type_check_atm env) atms in
        if List.length arg_tys = List.length atms then
          (* all arguments have types *)
          Some (type_check_op op arg_tys)
        else  (* just use the known return type of the operator *)
          Some (type_check_op_ret op)

let type_check_stmt (env : ty_env_t) (s : stmt) : ty_env_t =
  match s with
    | Assign (v, e) ->
      begin
        match type_check_exp env e with
          | None -> env
          | Some e_ty -> add_type_info v e_ty env
      end

    | PrimS (`Read, []) -> env
    | PrimS (`Read, _) -> ty_err_simple "read: wrong number of arguments"

    | PrimS (`Print, [a]) ->
      begin
        match type_check_atm env a with
          | None -> (all_assigned := false; env)
          | Some Integer -> env
          | Some t -> ty_err "return expression" ~expected:Integer ~got:t
      end
    | PrimS (`Print, _) -> ty_err_simple "print: wrong number of arguments"

(* Type check a tail.
 * Return the resulting type environment. *)
let rec type_check_tail (env : ty_env_t) (t : tail) : ty_env_t =
  match t with
    | Return e -> 
      begin
        match type_check_exp env e with
          | None
          | Some Integer -> env
          | Some t -> ty_err "return expression" ~expected:Integer ~got:t
      end
    | Goto _ -> env
    | Seq (s, t) ->
      let env' = type_check_stmt env s in
        type_check_tail env' t
    | IfStmt { op; arg1; arg2; _ } ->
      begin
        match type_check_exp env (Prim ((op :> core_op), [arg1; arg2])) with
          | None
          | Some Boolean -> env
          | Some t -> ty_err "if test expression" ~expected:Boolean ~got:t
      end

(* Make sure all variables have types. *)
let check_vars (vlst : var list) (env : ty_env_t) : unit =
  List.iter
    (fun v ->
       if not (Env.mem v env) then
         ty_err_simple @@
           Printf.sprintf "check_vars: variable (%s) has no type binding" v
       else
         ())
    vlst

(* Type check all labeled tails.
 * Do multiple passes, until all variables have types.
 * This is inefficient but we're not worried about that here.
 *)
let compute_ty_env (lmap : tail LabelMap.t) : ty_env_t =
  let one_pass (env : ty_env_t) : ty_env_t =
    List.fold_left
      (fun env (_, tl) -> type_check_tail env tl)
      env
      (LabelMap.bindings lmap)
  in
  let rec assign_to_fixpoint (env : ty_env_t) : ty_env_t =
    let _ = all_assigned := true in
    let env' = one_pass env in
      if !all_assigned then
        env'
      else
        begin
          (* Printf.printf "%s\n%!" (VarMap.to_string sexp_of_ty env'); *)
          assign_to_fixpoint env'
        end
  in
    assign_to_fixpoint Env.empty

let type_check (CProgram (Info _, lts) as p) =
  let lmap = LabelMap.of_list lts in
  let env = compute_ty_env lmap in
  let vars = get_vars p in
  let _ = check_vars vars env in
  (* Throw away the old (empty) `Info` field, which is empty.
   * Replace it with the type information for each variable. *)
  let locals_types = Env.bindings env in
  let info = Info { locals_types } in
    CProgram (info, lts)
