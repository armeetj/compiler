open Support
open Support.Utils
open Types
open Lvar_mon
module L = Lvar

let fresh = Utils.make_gensym ()
let gen_temp_name () = fresh ~base:"$tmp" ~sep:"."

(* Convert an expression which needs to become atomic.
 * Return the atomic expression as well as a list of
 * names bound to complex operands. *)
let rec rco_atom (e : L.exp) binding_lst : (var * exp) list * atm =
  match e with
  | L.Int i -> (binding_lst, Int i)
  | L.Var v -> (binding_lst, Var v)
  | L.Read ->
      let sym = gen_temp_name () in
      let exp = Let (sym, Read, Atm (Var sym)) in
      ((sym, exp) :: binding_lst, Var sym)
  | L.Negate e ->
      let sym = gen_temp_name () in
      let binding_lst, e_atm = rco_atom e binding_lst in
      ((sym, Negate e_atm) :: binding_lst, Var sym)
  | L.Add (e1, e2) ->
      let sym = gen_temp_name () in
      let binding_lst, e1_atm = rco_atom e1 binding_lst in
      let binding_lst, e2_atm = rco_atom e2 binding_lst in
      ((sym, Add (e1_atm, e2_atm)) :: binding_lst, Var sym)
  | L.Sub (e1, e2) ->
      let sym = gen_temp_name () in
      let binding_lst, e1_atm = rco_atom e1 binding_lst in
      let binding_lst, e2_atm = rco_atom e2 binding_lst in
      ((sym, Sub (e1_atm, e2_atm)) :: binding_lst, Var sym)
  | L.Let (v, e1, e2) -> (* this is wrong, we have to figure out how to handle this *)
      let sym = gen_temp_name () in
      ((sym, Let (v, rco_exp e1, rco_exp e2)) :: binding_lst, Var sym)

and rco_exp (e : L.exp) : exp =
  let rec construct (e : L.exp) : exp =
    let bindings_lst, exp_atm = rco_atom e [] in
    (* let () = (sexp_of_atm exp_atm) |> print_sexp in
       let () = Printf.printf("!!!") in *)
    Atm (Var "todo")
  in

  construct e

let remove_complex_operands (prog : L.program) : program =
  let (L.Program exp) = prog in
  Program (rco_exp exp)
