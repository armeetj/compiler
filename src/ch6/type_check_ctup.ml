open Support.Utils
open Ctup
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
        ty_err_simple
        @@ Printf.sprintf
             "variable [%s] type conflict: was [%s] but is now [%s]" v
             (string_of_ty t) (string_of_ty t')
      else env

let type_check_atm (env : ty_env_t) (a : atm) : ty option =
  match a with
  | Void -> Some Unit
  | Bool _ -> Some Boolean
  | Int _ -> Some Integer
  | Var v -> (
      match Env.find_opt v env with
      | None ->
          all_assigned := false;
          None
      | Some t -> Some t)

let type_check_exp (env : ty_env_t) (e : exp) : ty option =
  match e with
  | Atm a -> type_check_atm env a
  | Prim (op, atms) ->
      let arg_tys = List.filter_map (type_check_atm env) atms in
      if List.length arg_tys = List.length atms then
        (* all arguments have types *)
        Some (type_check_op op arg_tys)
      else
        (* just use the known return type of the operator *)
        Some (type_check_op_ret op)
  | Allocate (_, t) -> Some t
  | GlobalVal v -> (
      match v with
      | "free_ptr" -> Some Integer
      | "fromspace_end" -> Some Integer
      | _ -> failwithf "unknown global variable (%s)" v)
  | VecLen a -> (
      let vec_ty = type_check_atm env a in
      match vec_ty with
      | None -> None
      | Some (Vector _) -> Some Integer
      | Some t ->
          ty_err_simple
          @@ Printf.sprintf
               "vector-length statement: expected a vector, got: %s"
               (string_of_ty t))
  | VecRef (a, i) -> (
      let vec_ty = type_check_atm env a in
      match vec_ty with
      | None -> None
      | Some (Vector vec) ->
          if i < 0 || i >= Array.length vec then
            ty_err_simple
            @@ Printf.sprintf "vector-ref statement: index %d is out of range" i
          else Some vec.(i)
      | Some t ->
          ty_err_simple
          @@ Printf.sprintf "vector-ref statement: expected a vector, got: %s"
               (string_of_ty t))
  | VecSet (a1, i, a2) -> (
      let vec_ty = type_check_atm env a1 in
      match vec_ty with
      | None -> None
      | Some (Vector vec) -> (
          if i < 0 || i >= Array.length vec then
            ty_err_simple
            @@ Printf.sprintf "vector-set! statement: index %d is out of range"
                 i
          else
            match type_check_atm env a2 with
            | None -> None
            | Some t2 ->
                if t2 <> vec.(i) then
                  ty_err_simple
                  @@ Printf.sprintf
                       ("vector-set! statement: "
                      ^^ "expected type %s at index %d; got %s")
                       (string_of_ty vec.(i))
                       i (string_of_ty t2)
                else Some Unit)
      | Some t ->
          ty_err_simple
          @@ Printf.sprintf "vector-set! statement: expected a vector, got: %s"
               (string_of_ty t))

let type_check_stmt (env : ty_env_t) (s : stmt) : ty_env_t =
  match s with
  | Assign (v, e) -> (
      match type_check_exp env e with
      | None -> env
      | Some e_ty -> add_type_info v e_ty env)
  | PrimS (`Read, []) -> env
  | PrimS (`Read, _) -> ty_err_simple "read: wrong number of arguments"
  | PrimS (`Print, [ a ]) -> (
      match type_check_atm env a with
      | None ->
          all_assigned := false;
          env
      | Some Integer -> env
      | Some t -> ty_err "return expression" ~expected:Integer ~got:t)
  | PrimS (`Print, _) -> ty_err_simple "print: wrong number of arguments"
  | Collect _ -> env
  | VecSetS (a1, i, a2) -> (
      match type_check_atm env a1 with
      | None -> env
      | Some (Vector vec) -> (
          if i < 0 || i >= Array.length vec then
            ty_err_simple
            @@ Printf.sprintf "vector-set! statement: index %d is out of range"
                 i
          else
            match type_check_atm env a2 with
            | None -> env
            | Some t2 ->
                if t2 <> vec.(i) then
                  ty_err_simple
                  @@ Printf.sprintf
                       ("vector-set! statement: "
                      ^^ "expected type %s at index %d; got %s")
                       (string_of_ty vec.(i))
                       i (string_of_ty t2)
                else env)
      | Some t ->
          ty_err_simple
          @@ Printf.sprintf "vector-set! statement: expected a vector, got: %s"
               (string_of_ty t))

(* Type check a tail.
 * Return the resulting type environment. *)
let rec type_check_tail (env : ty_env_t) (t : tail) : ty_env_t =
  match t with
  | Return e -> (
      match type_check_exp env e with
      | None | Some Integer -> env
      | Some t -> ty_err "return expression" ~expected:Integer ~got:t)
  | Goto _ -> env
  | Seq (s, t) ->
      let env' = type_check_stmt env s in
      type_check_tail env' t
  | IfStmt { op; arg1; arg2; _ } -> (
      match type_check_exp env (Prim ((op :> core_op), [ arg1; arg2 ])) with
      | None | Some Boolean -> env
      | Some t -> ty_err "if test expression" ~expected:Boolean ~got:t)

(* Make sure all local variables have types. *)
let check_vars (vlst : var list) (env : ty_env_t) : unit =
  (* Ignore global variables. *)
  let global_vars = [ "free_ptr"; "fromspace_end" ] in
  List.iter
    (fun v ->
      if (not (List.mem v global_vars)) && not (Env.mem v env) then
        ty_err_simple
        @@ Printf.sprintf "check_vars: variable (%s) has no type binding" v
      else ())
    vlst

(* Type check all labeled tails.
 * Do multiple passes, until all variables have types.
 * This is inefficient but we're not worried about that here. *)
let compute_ty_env (lmap : tail LabelMap.t) : ty_env_t =
  let one_pass (env : ty_env_t) : ty_env_t =
    List.fold_left
      (fun env (_, tl) -> type_check_tail env tl)
      env (LabelMap.bindings lmap)
  in
  let rec assign_to_fixpoint (env : ty_env_t) : ty_env_t =
    let _ = all_assigned := true in
    let env' = one_pass env in
    if !all_assigned then env'
    else
      (* Printf.printf "%s\n%!" (VarMap.to_string sexp_of_ty env'); *)
      assign_to_fixpoint env'
  in
  assign_to_fixpoint Env.empty

let type_check (CProgram (Info _, lts) as p) =
  let lmap = LabelMap.of_list lts in
  let ty_env = compute_ty_env lmap in
  let vars = get_vars p in
  let _ = check_vars vars ty_env in
  (* Throw away the old (empty) `Info` field, which is empty.
   * Replace it with the type information for each variable. *)
  let locals_types = Env.bindings ty_env in
  let info = Info { locals_types } in
  CProgram (info, lts)
