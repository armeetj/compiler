open Support.Utils
open Types
open Cvar

type env_t = int Env.t

let interp_atm env atm : int =
  match atm with
  | Int i -> i
  | Var v -> (
      match Env.find_opt v env with
      | None -> failwithf "interp_atm: variable (%s) not found" v
      | Some i -> i)

let interp_exp env exp : int =
  match exp with
  | Atm a -> interp_atm env a
  | Read -> read_int ()
  | Negate a -> -interp_atm env a
  | Add (a1, a2) -> interp_atm env a1 + interp_atm env a2
  | Sub (a1, a2) -> interp_atm env a1 - interp_atm env a2

let interp_stmt env stmt : env_t =
  match stmt with Assign (v, e) -> Env.add v (interp_exp env e) env

let rec interp_tail env tail : env_t * int =
  match tail with
  | Return e -> (env, interp_exp env e)
  | Seq (stmt, t) ->
      let env' = interp_stmt env stmt in
      interp_tail env' t

let rec interp_labeled_tails env lts : env_t * int =
  match lts with
  | [] -> failwith "nothing to interpret"
  | [ (_, t) ] -> interp_tail env t
  | (_, t) :: lts' ->
      let env', _ = interp_tail env t in
      interp_labeled_tails env' lts'

let interp (CProgram (_, labeled_tails)) : int =
  (* Discard environment. *)
  let _, i = interp_labeled_tails Env.empty labeled_tails in
  i
