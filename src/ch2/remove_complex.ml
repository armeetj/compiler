open Support
open Types
open Lvar_mon
module L = Lvar

let fresh = Utils.make_gensym ()
let gen_temp_name () = fresh ~base:"$tmp" ~sep:"."

(* Convert an expression which needs to become atomic.
 * Return the atomic expression as well as a list of
 * names bound to complex operands. *)

let rec rco_atom (e : L.exp) : (var * exp) list * atm =
  match e with
  | L.Int i -> ([], Int i)
  | L.Var v -> ([], Var v)
  | L.Read ->
      let exp = Read in
      let sym = gen_temp_name () in
      ([ (sym, exp) ], Var sym)
  | L.Negate e ->
      let binding_lst, e_atm = rco_atom e in
      let sym = gen_temp_name () in
      ((sym, Negate e_atm) :: binding_lst, Var sym)
  | L.Add (e1, e2) ->
      let binding_lst_1, e1_atm = rco_atom e1 in
      let binding_lst_2, e2_atm = rco_atom e2 in
      let binding_list = binding_lst_2 @ binding_lst_1 in
      let sym = gen_temp_name () in
      ((sym, Add (e1_atm, e2_atm)) :: binding_list, Var sym)
  | L.Sub (e1, e2) ->
      let binding_lst_1, e1_atm = rco_atom e1 in
      let binding_lst_2, e2_atm = rco_atom e2 in
      let binding_list = binding_lst_2 @ binding_lst_1 in
      let sym = gen_temp_name () in
      ((sym, Sub (e1_atm, e2_atm)) :: binding_list, Var sym)
  | L.Let (v, e1, e2) ->
      let e1 = rco_exp e1 in
      let binding_lst_2, e2_atm = rco_atom e2 in
      (binding_lst_2 @ [ (v, e1) ], e2_atm)

and rco_exp (e : L.exp) : exp =
  let rec construct (binding_lst : (var * exp) list) atm : exp =
    match binding_lst with
    | [] -> atm
    | (v, e) :: rest -> Let (v, e, construct rest atm)
  in
  match e with
  | L.Int i -> Atm (Int i)
  | L.Var v -> Atm (Var v)
  | L.Read -> Read
  | L.Let (v, e1, e2) -> Let (v, rco_exp e1, rco_exp e2)
  | L.Add (e1, e2) ->
      let bindings_lst1, e1_atm = rco_atom e1 in
      let bindings_lst2, e2_atm = rco_atom e2 in
      let bindings_lst = List.rev (bindings_lst2 @ bindings_lst1) in
      construct bindings_lst (Add (e1_atm, e2_atm))
  | L.Sub (e1, e2) ->
      let bindings_lst1, e1_atm = rco_atom e1 in
      let bindings_lst2, e2_atm = rco_atom e2 in
      let bindings_lst = List.rev (bindings_lst2 @ bindings_lst1) in
      construct bindings_lst (Sub (e1_atm, e2_atm))
  | L.Negate e ->
      let bindings_lst, e_atm = rco_atom e in
      let bindings_lst = List.rev bindings_lst in
      construct bindings_lst (Negate e_atm)

let remove_complex_operands (prog : L.program) : program =
  let (L.Program exp) = prog in
  Program (rco_exp exp)