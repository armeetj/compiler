open Support
open Types
open Lvar_mon
module L = Lvar

let fresh = Utils.make_gensym ()

let gen_temp_name () = fresh ~base:"$tmp" ~sep:"."

(*
   creates the chain of lets using the bindings list.
   - the last expression should maintain throughout.
   - assumes bindings are in correct order
*)
let process (bindings : (var * exp) list) (last : exp) : exp =
  List.fold_right (fun (v, e) acc -> Let (v, e, acc)) bindings last

(* Convert an expression which needs to become atomic.
 * Return the atomic expression as well as a list of
 * names bound to complex operands. *)
let rec rco_atom (e : L.exp) : (var * exp) list * atm =
  match e with
  | L.Int i ->
      ([], Int i)
  | L.Var v ->
      ([], Var v)
  | L.Read ->
      let tmp = gen_temp_name () in
      ([(tmp, Read)], Var tmp)
  (* order of variable creation
     inner -> outer (ensure tmp is after processing).
     left -> right (bindings order) *)
  | L.Negate exp ->
      let bindings, atm = rco_atom exp in
      let tmp = gen_temp_name () in
      (bindings @ [(tmp, Negate atm)], Var tmp)
  | L.Add (exp1, exp2) ->
      let bindings1, atm1 = rco_atom exp1 in
      let bindings2, atm2 = rco_atom exp2 in
      let tmp = gen_temp_name () in
      (bindings1 @ bindings2 @ [(tmp, Add (atm1, atm2))], Var tmp)
  | L.Sub (exp1, exp2) ->
      let bindings1, atm1 = rco_atom exp1 in
      let bindings2, atm2 = rco_atom exp2 in
      let tmp = gen_temp_name () in
      (bindings1 @ bindings2 @ [(tmp, Sub (atm1, atm2))], Var tmp)
  | L.Let (v, exp1, exp2) ->
      (*
         the new first binding has to be the let variable to the let expression
         we add to the first because if a let is nested it has to be removed from
         the outer instruction.
         last atm to be returned is updated to the let.
      *)
      let bindings, atm = rco_atom exp2 in
      let e1 = rco_exp exp1 in
      ([(v, e1)] @ bindings, atm)

and rco_exp (e : L.exp) : exp =
  (* returns the final result *)
  match e with
  | L.Int i ->
      Atm (Int i)
  | L.Var v ->
      Atm (Var v)
  | L.Read ->
      Read
  | L.Let (v, exp1, exp2) ->
      Let (v, rco_exp exp1, rco_exp exp2)
  (* operations. have to ensure that args are atoms *)
  | L.Negate exp ->
      let bindings, atm = rco_atom exp in
      (* the final expression should be negate of the final atom
         bindings before that are the chain of lets.
         so, we remove negate from exp, and pass it into process.
         we then atomize the expression, and extract bindings.
      *)
      process bindings (Negate atm)
  | L.Add (exp1, exp2) ->
      let bindings1, atm1 = rco_atom exp1 in
      let bindings2, atm2 = rco_atom exp2 in
      process (bindings1 @ bindings2) (Add (atm1, atm2))
  | L.Sub (exp1, exp2) ->
      let bindings1, atm1 = rco_atom exp1 in
      let bindings2, atm2 = rco_atom exp2 in
      process (bindings1 @ bindings2) (Sub (atm1, atm2))

let remove_complex_operands (prog : L.program) : program =
  let (L.Program exp) = prog in
  Program (rco_exp exp)
