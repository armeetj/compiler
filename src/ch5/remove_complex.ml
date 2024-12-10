(* ch5 *)
open Support
open Types
open Lwhile_mon
module L = Lwhile_get

let fresh = Utils.make_gensym ()

let gen_temp_name () = fresh ~base:"$tmp" ~sep:"."

(*
   creates the chain of lets using the bindings list.
   - the last expression should maintain throughout.
   - assumes bindings are in correct order
*)
let process (bindings : (var * exp) list) last : exp =
  List.fold_right (fun (v, exp) acc -> Let (v, exp, acc)) bindings last

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
  | L.Void ->
      ([], Void)
  (* Don't think too deeply. If you have this as an arg
     just assign a variable to the result and let that var be the arg
  *)
  | L.If (exp1, exp2, exp3) ->
      let exp1 = rco_exp exp1 in
      let exp2 = rco_exp exp2 in
      let exp3 = rco_exp exp3 in
      let tmp = gen_temp_name () in
      ([(tmp, If (exp1, exp2, exp3))], Var tmp)
  | L.SetBang (v, exp) ->
      let exp = rco_exp exp in
      let tmp = gen_temp_name () in
      ([(tmp, SetBang (v, exp))], Void)
  | L.Begin (exp_lst, exp) ->
      let exp_lst = List.map rco_exp exp_lst in
      let exp = rco_exp exp in
      let tmp = gen_temp_name () in
      ([(tmp, Begin (exp_lst, exp))], Var tmp)
  | L.While (exp1, exp2) ->
      let exp1 = rco_exp exp1 in
      let exp2 = rco_exp exp2 in
      let tmp = gen_temp_name () in
      ([(tmp, While (exp1, exp2))], Void)
  | L.GetBang v ->
      let tmp = gen_temp_name () in
      ([(tmp, Atm (Var v))], Var tmp)
  (* operations that require deeper recursion
     since they can't have non-atomic args*)
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
  (* Let case, weird as usual *)
  | L.Let (v, exp1, exp2) ->
      let bindings, atm = rco_atom exp2 in
      let e1 = rco_exp exp1 in
      ([(v, e1)] @ bindings, atm)

and rco_exp (e : L.exp) : exp =
  match e with
  | L.Void ->
      Atm Void
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
  | L.SetBang (v, exp) ->
      SetBang (v, rco_exp exp)
  | L.GetBang v ->
      Atm (Var v)
  | L.While (exp1, exp2) ->
      let exp1 = rco_exp exp1 in
      let exp2 = rco_exp exp2 in
      While (exp1, exp2)
  | L.Begin (exp_lst, exp) ->
      let helper exp_lst = List.map (fun exp -> rco_exp exp) exp_lst in
      let exp_lst = helper exp_lst in
      Begin (exp_lst, rco_exp exp)
  | L.If (exp1, exp2, exp3) ->
      let exp1 = rco_exp exp1 in
      let exp2 = rco_exp exp2 in
      let exp3 = rco_exp exp3 in
      If (exp1, exp2, exp3)
  | L.Prim (cop, exp_lst) ->
      let bindings, atm_lst =
        List.fold_left
          (fun (bindings, atms) exp ->
            let binding, atm = rco_atom exp in
            (bindings @ binding, atms @ [atm]) )
          ([], []) exp_lst
      in
      process bindings (Prim (cop, atm_lst))

let remove_complex_operands (prog : L.program) : program =
  let (L.Program exp) = prog in
  Program (rco_exp exp)
