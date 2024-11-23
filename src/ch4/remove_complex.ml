open Support
open Types
open Lif_mon
module L = Lif_shrink

let fresh = Utils.make_gensym ()

let gen_temp_name () = fresh ~base:"$tmp" ~sep:"."

(*
   creates the chain of lets using the bindings list.
   - the last expression should maintain throughout.
   - assumes bindings are in correct order
*)
let rec process (bindings : (var * exp) list) last : exp =
  match bindings with
  | [] ->
      last
  | h :: t ->
      let v, exp = h in
      Let (v, exp, process t last)

(* Convert an expression which needs to become atomic.
 * Return the atomic expression as well as a list of
 * names bound to complex operands. *)
let rec rco_atom (e : L.exp) : (var * exp) list * atm =
  match e with
  | L.Bool b ->
      ([], Bool b)
  | L.Int i ->
      ([], Int i)
  | L.Var v ->
      ([], Var v)
  | L.If (exp1, exp2, exp3) ->
      let exp1 = rco_exp exp1 in
      let exp2 = rco_exp exp2 in
      let exp3 = rco_exp exp3 in
      let tmp = gen_temp_name () in
      ([(tmp, If (exp1, exp2, exp3))], Var tmp)
  | L.Prim (cop, exp_lst) ->
      let rec helper exp_lst =
        match exp_lst with
        | [] ->
            ([], [])
        | h :: t ->
            let binding, atm = rco_atom h in
            let bindings, atms = helper t in
            (binding @ bindings, atm :: atms)
      in
      let bindings, atm_lst = helper exp_lst in
      let tmp = gen_temp_name () in
      (bindings @ [(tmp, Prim (cop, atm_lst))], Var tmp)
  | L.Let (v, exp1, exp2) ->
      let bindings, atm = rco_atom exp2 in
      let e1 = rco_exp exp1 in
      ([(v, e1)] @ bindings, atm)

and rco_exp (e : L.exp) : exp =
  match e with
  | L.Bool b ->
      Atm (Bool b)
  | L.Int i ->
      Atm (Int i)
  | L.Var v ->
      Atm (Var v)
  | L.Let (v, exp1, exp2) ->
      let exp1 = rco_exp exp1 in
      let exp2 = rco_exp exp2 in
      Let (v, exp1, exp2)
  | L.If (exp1, exp2, exp3) ->
      let exp1 = rco_exp exp1 in
      let exp2 = rco_exp exp2 in
      let exp3 = rco_exp exp3 in
      If (exp1, exp2, exp3)
  | L.Prim (cop, exp_lst) ->
      let rec helper exp_lst =
        match exp_lst with
        | [] ->
            ([], [])
        | h :: t ->
            let binding, atm = rco_atom h in
            let bindings, atms = helper t in
            (binding @ bindings, atm :: atms)
      in
      let bindings, atm_lst = helper exp_lst in
      process bindings (Prim (cop, atm_lst))

let remove_complex_operands (prog : L.program) : program =
  let (L.Program exp) = prog in
  Program (rco_exp exp)
