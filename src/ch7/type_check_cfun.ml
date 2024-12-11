open Support.Utils
open Cfun
open Types
open Type_check

(* Boolean value which is `true` if all names have been assigned types. *)
let all_assigned = ref true

(* Add a variable->type binding to the type environment.
 * If a variable with a type is encounted,
 * make sure it has the same type. *)
let add_type_info (v : var) (t : ty) (ty_env : ty_env_t) : ty_env_t =
  match Env.find_opt v ty_env with
    | None -> Env.add v t ty_env
    | Some t' ->
        if not (ty_equal t t') then
          ty_err_simple @@
          Printf.sprintf
            ("add_type_info: " ^^
             "variable [%s] type conflict: was [%s] but is now [%s]")
            v (string_of_ty t) (string_of_ty t')
        else
          ty_env

let type_check_atm (ty_env : ty_env_t) (a : atm) : ty option =
  match a with
    | Void   -> Some Unit
    | Bool _ -> Some Boolean
    | Int _  -> Some Integer
    | Var v  ->
        begin
          match Env.find_opt v ty_env with
            | None -> (all_assigned := false; None)
            | Some t -> Some t
        end

(* Type check a non-primitive function call. *)
let type_check_call (ty_env : ty_env_t) (f : atm) (args: atm list)
  : ty option =
  let arg_tys = List.filter_map (type_check_atm ty_env) args in
    match type_check_atm ty_env f with
      | None -> None
      | Some ty ->
          begin
            match ty with
              | Function (arg_tys', ret_ty) ->
                  if List.length arg_tys = List.length args then
                    begin
                      (* all arguments have types *)
                      if arg_tys = arg_tys' then
                        Some ret_ty
                      else
                        ty_err_simple
                          "type_check_call: argument type mismatch"
                    end
                  else
                    (* Can't do a full type check, so just use return type. *)
                    Some ret_ty
              | _ ->
                  ty_err_simple
                    "type_check_call: non-function in function position"
          end

let type_check_exp (ty_env : ty_env_t) (e : exp) : ty option =
  match e with
    | Atm a ->
        type_check_atm ty_env a

    | Prim (op, atms) ->
        let arg_tys = List.filter_map (type_check_atm ty_env) atms in
          if List.length arg_tys = List.length atms then
            (* all arguments have types *)
            Some (type_check_op op arg_tys)
          else  (* just use the known return type of the operator *)
            Some (type_check_op_ret op)

    | Allocate (_, t) ->
        Some t

    | GlobalVal v ->
        begin
          match v with
            | "free_ptr"      -> Some Integer
            | "fromspace_end" -> Some Integer
            | _ -> failwithf
                     "type_check_exp: global-val : unknown global variable (%s)" v
        end

    | VecLen a ->
        let vec_ty = type_check_atm ty_env a in
          begin
            match vec_ty with
              | None -> None
              | Some (Vector _) -> Some Integer
              | Some t ->
                  ty_err_simple @@
                  Printf.sprintf
                    ("type_check_exp: " ^^
                     "vector-length : expected a vector, got: %s")
                    (string_of_ty t)
          end

    | VecRef (a, i) ->
        let vec_ty = type_check_atm ty_env a in
          begin
            match vec_ty with
              | None -> None
              | Some (Vector vec) ->
                  if i < 0 || i >= Array.length vec then
                    ty_err_simple @@
                    Printf.sprintf
                      ("type_check_exp: " ^^
                       "vector-ref : index %d is out of range") i
                  else
                    Some vec.(i)
              | Some t ->
                  ty_err_simple @@
                  Printf.sprintf
                    ("type_check_exp: " ^^
                     "vector-ref : expected a vector, got: %s")
                    (string_of_ty t)
          end

    | VecSet (a1, i, a2) ->
        let vec_ty = type_check_atm ty_env a1 in
          begin
            match vec_ty with
              | None -> None
              | Some (Vector vec) ->
                  if i < 0 || i >= Array.length vec then
                    ty_err_simple @@
                    Printf.sprintf
                      ("type_check_exp: " ^^
                       "vector-set! : index %d is out of range") i
                  else
                    begin
                      match type_check_atm ty_env a2 with
                        | None -> None
                        | Some t2 ->
                            if t2 <> vec.(i) then
                              ty_err_simple @@
                              Printf.sprintf
                                ("type_check_exp: " ^^
                                 "vector-set! : " ^^
                                 "expected type %s at index %d; got %s")
                                (string_of_ty vec.(i)) i (string_of_ty t2)
                            else
                              Some Unit
                    end
              | Some t ->
                  ty_err_simple @@
                  Printf.sprintf
                    ("type_check_exp: " ^^
                     "vector-set! : expected a vector, got: %s")
                    (string_of_ty t)
          end

    | FunRef (Label lbl, i) ->
        begin
          match Env.find_opt lbl ty_env with
            | None ->
                ty_err_simple @@
                Printf.sprintf
                  ("type_check_exp: " ^^
                   "fun-ref : no binding for function %s") lbl
            | Some ty ->
                begin
                  (* Check that the type is a function type
                     and has arity `i`. *)
                  match ty with
                    | Function (arg_tys, _) ->
                        if List.length arg_tys = i then
                          Some ty
                        else
                          ty_err_simple @@
                          Printf.sprintf
                            ("type_check_exp: " ^^
                             "fun-ref : wrong function arity for %s") lbl
                    | _ ->
                        ty_err_simple @@
                        Printf.sprintf
                          ("type_check_exp: " ^^
                           "fun-ref : non-function type for %s") lbl
                end
        end

    | Call (atm, atms) ->
        type_check_call ty_env atm atms

let type_check_stmt (ty_env : ty_env_t) (s : stmt) : ty_env_t =
  match s with
    | Assign (v, e) ->
        (* NOTE: `Assign` statements are the only part of the language 
           that adds type information to environments. *)
        begin
          match type_check_exp ty_env e with
            | None -> ty_env
            | Some e_ty -> add_type_info v e_ty ty_env
        end

    | PrimS (`Read, []) -> ty_env
    | PrimS (`Read, _) ->
        ty_err_simple
          ("type_check_stmt: " ^
           "read : wrong number of arguments")

    | PrimS (`Print, [a]) ->
        begin
          match type_check_atm ty_env a with
            | None ->
                (all_assigned := false; ty_env)
            | Some Integer ->
                ty_env
            | Some t ->
                ty_err "return expression" ~expected:Integer ~got:t
        end
    | PrimS (`Print, _) ->
        ty_err_simple
          ("type_check_stmt: " ^
           "print: wrong number of arguments")

    | CallS (atm, atms) ->
        begin
          ignore (type_check_call ty_env atm atms);
          ty_env
        end

    | Collect _ -> ty_env

    | VecSetS (a1, i, a2) ->
        begin
          match type_check_atm ty_env a1 with
            | None -> ty_env

            | Some (Vector vec) ->
                if i < 0 || i >= Array.length vec then
                  ty_err_simple @@
                  Printf.sprintf
                    ("type_check_stmt: " ^^
                     "vector-set! : index %d is out of range") i
                else
                  begin
                    match type_check_atm ty_env a2 with
                      | None -> ty_env

                      | Some t2 ->
                          if t2 <> vec.(i) then
                            ty_err_simple @@
                            Printf.sprintf
                              ("type_check_stmt: " ^^
                               "vector-set! : " ^^
                               "expected type %s at index %d; got %s")
                              (string_of_ty vec.(i)) i (string_of_ty t2)
                          else
                            ty_env
                  end

            | Some t ->
                ty_err_simple @@
                Printf.sprintf
                  ("type_check_stmt: " ^^
                   "vector-set! : expected a vector, got: %s")
                  (string_of_ty t)
        end

(* Type check a tail.
 * Return the resulting type environment. *)
let rec type_check_tail (ty_env : ty_env_t) (t : tail) : ty_env_t =
  match t with
    | Return e ->
        begin
          ignore (type_check_exp ty_env e);
          ty_env
        end

    | TailCall (atm, atms) ->
        begin
          ignore (type_check_call ty_env atm atms);
          ty_env
        end

    | Goto _ -> ty_env

    | Seq (s, t) ->
        let ty_env' = type_check_stmt ty_env s in
          type_check_tail ty_env' t

    | IfStmt { op; arg1; arg2; _ } ->
        begin
          match type_check_exp ty_env
                  (Prim ((op :> core_op), [arg1; arg2])) with
            | None
            | Some Boolean ->
                ty_env
            | Some t ->
                ty_err "if test expression" ~expected:Boolean ~got:t
        end

(* Type check a tail which could be a return value of a function.
 * Return the type, if present, or None if it can't be a return value
 * (e.g. a `Seq`, `Goto`, or `IfStmt`).
 * This assumes that internal type checking is complete,
 * so all variables should have types.
 * Therefore, we don't have to return the type environment.
*)
let type_check_tail_return (ty_env : ty_env_t) (t : tail) : ty option =
  match t with
    | Return e ->
        begin
          match type_check_exp ty_env e with
            | None ->
                ty_err_simple "type_check_tail_return: return with no type"
            | Some t ->
                Some t
        end

    | TailCall (atm, atms) ->
        type_check_call ty_env atm atms

    | Goto _ 
    | Seq _
    | IfStmt _ ->
        None

(* Type check all labeled tails,
 * given the types of all global functions (including this one).
 * Do multiple passes, until all variables have types.
 * This is inefficient but we're not worried about that here. *)
let compute_ty_env (ty_env : ty_env_t) (lmap : tail LabelMap.t)
  : ty_env_t =
  let one_pass (env : ty_env_t) : ty_env_t =
    List.fold_left
      (fun env (_, tl) -> type_check_tail env tl)
      env
      (LabelMap.bindings lmap)
  in
  let rec assign_to_fixpoint (ty_env : ty_env_t) : ty_env_t =
    let _ = all_assigned := true in
    let ty_env' = one_pass ty_env in
      if !all_assigned then
        ty_env'
      else
        begin
          (* Printf.printf "%s\n%!" (VarMap.to_string sexp_of_ty env'); *)
          assign_to_fixpoint ty_env'
        end
  in
    assign_to_fixpoint ty_env

(* Get the computed types of all (and only) the local variables.
   If a local variable isn't in the type environment, it's an error. *)
let get_locals_types (vlst : var list) (ty_env : ty_env_t) : (var * ty) list =
  (* Make sure the variables are unique. *)
  let vset = VarSet.of_list vlst in
  (* Remove the global variables from `vset`. *)
  let global_vars = VarSet.of_list ["free_ptr"; "fromspace_end"] in
  let vset' = VarSet.diff vset global_vars in
    VarSet.fold
      (fun v map ->
         match Env.find_opt v ty_env with
           | None -> ty_err_simple @@
               Printf.sprintf
                 "get_locals_types: variable (%s) has no type binding" v
           | Some ty ->
               VarMap.add v ty map)
      vset'
      VarMap.empty
    |> VarMap.bindings

(* Type check a single definition,
   given the types of all global functions.
   Fill in the computed types of all local variables.
   Return the updated definition. *)
let type_check_def (ty_env : ty_env_t) (d : def) : def =
  let Def (lbl, fc) = d in
  (* Add argument types to local type environment. *)
  let ty_env' =
    List.fold_left (fun env (v, t) -> Env.add v t env) ty_env fc.args
  in
  let lts = fc.body in
  let lmap = LabelMap.of_list lts in
  (* We don't add the types of the locals because
     they haven't been computed yet. *)
  let ty_env'' = compute_ty_env ty_env' lmap in
  let vars = get_vars lts in
  let locals = get_locals_types vars ty_env'' |> List.sort compare in
  (* Check that the return type is what's expected.
     Type check all tails that can be return values of functions,
     and make sure each of them has the same type
     as the nominal return type. *)
  let ret_tys =
    lts
    |> List.map snd  (* only tails *)
    |> List.filter_map (type_check_tail_return ty_env'')
  in
    if List.for_all (fun ret_ty -> ret_ty = fc.ret) ret_tys then
      let fc' = { fc with locals } in
        Def (lbl, fc')
    else
      failwithf
        "invalid return type(s) for function %s" (string_of_label lbl)

let ty_of_fun_contents name { args; ret; _ } =
  let (formals, ts) = List.split args in
    if no_string_repeats formals then
      Function (ts, ret)
    else
      let formals_string = String.concat " " formals in
        failwithf "cfun: repeated formal arguments in function %s: (%s)"
          name formals_string

let type_check_def_decl (d : def) : var * ty =
  let Def (Label v, fv) = d in
  let f_ty = ty_of_fun_contents v fv in
    (v, f_ty)

let type_check (prog : program) : program =
  let (CProgram defs) = prog in
  (* Create a top-level type environment
     from the global function declarations. *)
  let ty_env =
    List.fold_left
      (fun env d ->
         let (v, f_ty) = type_check_def_decl d in
           Env.add v f_ty env)
      empty_ty_env
      defs
  in
    CProgram (List.map (type_check_def ty_env) defs)
