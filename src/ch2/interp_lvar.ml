open Support.Utils
open Types
open Lvar

let rec interp_exp env exp =
  match exp with
  | Int i -> i
  | Var v -> (
      match Env.find_opt v env with
      | None -> failwithf "interp_exp: variable (%s) not found" v
      | Some i -> i)
  | Read -> read_int ()
  | Negate e -> -interp_exp env e
  | Add (e1, e2) ->
      (* Use `let`s to enforce the correct left-to-right evaluation order. *)
      let e1' = interp_exp env e1 in
      let e2' = interp_exp env e2 in
      e1' + e2'
  | Sub (e1, e2) ->
      (* Use `let`s to enforce the correct left-to-right evaluation order. *)
      let e1' = interp_exp env e1 in
      let e2' = interp_exp env e2 in
      e1' - e2'
  | Let (v, e1, e2) ->
      let new_env = Env.add v (interp_exp env e1) env in
      interp_exp new_env e2

let interp (Program exp) = interp_exp Env.empty exp
