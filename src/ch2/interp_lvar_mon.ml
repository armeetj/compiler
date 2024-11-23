open Support.Utils
open Types
open Lvar_mon

let interp_atm env = function
  | Int i ->
      i
  | Var v -> (
    match Env.find_opt v env with
    | None ->
        failwithf "interp_atm: variable (%s) not found" v
    | Some i ->
        i )

let rec interp_exp env exp =
  match exp with
  | Atm a ->
      interp_atm env a
  | Read ->
      read_int ()
  | Negate a ->
      -interp_atm env a
  | Add (a1, a2) ->
      (* We don't need the `let`s to enforce evaluation order,
       * but we do it anyway for clarity. *)
      let a1' = interp_atm env a1 in
      let a2' = interp_atm env a2 in
      a1' + a2'
  | Sub (a1, a2) ->
      let a1' = interp_atm env a1 in
      let a2' = interp_atm env a2 in
      a1' - a2'
  | Let (v, e1, e2) ->
      let new_env = Env.add v (interp_exp env e1) env in
      interp_exp new_env e2

let interp (Program exp) = interp_exp Env.empty exp
