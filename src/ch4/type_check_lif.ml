open Lif
open Types
open Type_check

let rec type_check_exp (env : ty_env) (e : exp) : ty =
  match e with
  | Bool _ ->
      Boolean
  | Int _ ->
      Integer
  | Var v -> (
    match Env.find_opt v env with
    | None ->
        ty_err_simple ("unbound variable: " ^ v)
    | Some t ->
        t )
  | Prim (op, es) ->
      let arg_tys = List.map (type_check_exp env) es in
      type_check_op op arg_tys
  | If (e1, e2, e3) ->
      let t1 = type_check_exp env e1 in
      let t2 = type_check_exp env e2 in
      let t3 = type_check_exp env e3 in
      if not (ty_equal t1 Boolean) then
        ty_err "if test expression" ~expected:Boolean ~got:t1
      else if not (ty_equal t2 t3) then
        ty_err "if else clause" ~expected:t2 ~got:t3
      else t2
  | And (e1, e2) ->
      let t1 = type_check_exp env e1 in
      let t2 = type_check_exp env e2 in
      if not (ty_equal t1 Boolean) then
        ty_err "and first expression" ~expected:Boolean ~got:t1
      else if not (ty_equal t2 Boolean) then
        ty_err "and second expression" ~expected:Boolean ~got:t1
      else Boolean
  | Or (e1, e2) ->
      let t1 = type_check_exp env e1 in
      let t2 = type_check_exp env e2 in
      if not (ty_equal t1 Boolean) then
        ty_err "or first expression" ~expected:Boolean ~got:t1
      else if not (ty_equal t2 Boolean) then
        ty_err "or second expression" ~expected:Boolean ~got:t1
      else Boolean
  | Let (v, e1, e2) ->
      let t1 = type_check_exp env e1 in
      let env' = Env.add v t1 env in
      type_check_exp env' e2

let type_check (Program e as prog) =
  match type_check_exp empty_ty_env e with
  | Integer ->
      prog
  | _ ->
      ty_err_simple "program should have type Integer"
