open Support
open Types
open Lif_mon
module L = Lif_shrink

let fresh = Utils.make_gensym ()
let gen_temp_name () = fresh ~base:"$tmp" ~sep:"."

(* Convert an expression which needs to become atomic.
 * Return the atomic expression as well as a list of
 * names bound to complex operands. *)
let rec rco_atom (e : L.exp) : (var * exp) list * atm =
  match e with
  | L.Bool b -> ([], Bool b)
  | L.Int i -> ([], Int i)
  | L.Var v -> ([], Var v)
  | L.Prim (op, exps) ->
      let binding_lst, atms =
        List.fold_left
          (fun (binding_lst, atms) e ->
            let bindings, atm = rco_atom e in
            (* TODO: check if bindings @ bindings_lst is reversed *)
            (bindings @ binding_lst, atms @ [ atm ]))
          ([], []) exps
      in
      let sym = gen_temp_name () in
      let final_binding = (sym, Prim (op, atms)) in
      (final_binding :: binding_lst, Var sym)
  (* TODO: check if this makes sense *)
  | L.If (cond_exp, then_exp, else_exp) ->
      let sym = gen_temp_name () in
      ( [ (sym, If (rco_exp cond_exp, rco_exp then_exp, rco_exp else_exp)) ],
        Var sym )
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
  | L.Bool b -> Atm (Bool b)
  | L.Int i -> Atm (Int i)
  | L.Var v -> Atm (Var v)
  (* TODO: impl *)
  | L.Prim (op, exps) ->
      let binding_lst, atms =
        List.fold_left
          (fun (binding_lst, atms) e ->
            let bindings, atm = rco_atom e in
            (* TODO: check if bindings @ bindings_lst is reversed *)
            (bindings @ binding_lst, atms @ [ atm ]))
          ([], []) exps
      in
      let binding_lst = List.rev binding_lst in
      construct binding_lst (Prim (op, atms))
  | L.If (cond_exp, then_exp, else_exp) ->
      If (rco_exp cond_exp, rco_exp then_exp, rco_exp else_exp)
  | L.Let (v, e1, e2) -> Let (v, rco_exp e1, rco_exp e2)

let remove_complex_operands (prog : L.program) : program =
  let (L.Program exp) = prog in
  Program (rco_exp exp)
