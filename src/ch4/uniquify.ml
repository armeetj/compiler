open Support
open Support.Utils
open Types
open Lif_shrink

let fresh = Utils.make_gensym ()

let uniquify_exp (e : exp) : exp =
  let rec un_helper e map =
    match e with
    | Let (sym, val_exp, res_exp) ->
        let un_bind_exp = un_helper val_exp map in
        let un_sym = fresh ~base:sym ~sep:"." in
        let nested_map = VarMap.add sym un_sym map in
        let un_body_exp = un_helper res_exp nested_map in
        Let (un_sym, un_bind_exp, un_body_exp)
    | Bool b ->
        Bool b
    | Int i ->
        Int i
    | Var sym ->
        if VarMap.mem sym map then Var (VarMap.find sym map) else Var sym
    | Prim (op, exp_lst) ->
        let new_exp_lst = List.map (fun e -> un_helper e map) exp_lst in
        Prim (op, new_exp_lst)
    | If (if_cond, if_then, if_else) ->
        If (un_helper if_cond map, un_helper if_then map, un_helper if_else map)
  in
  un_helper e VarMap.empty

let validate (e : exp) : unit =
  let rec aux (s : VarSet.t) (e : exp) : VarSet.t =
    match e with
    | Bool _ | Int _ | Var _ ->
        s
    | Prim (_, es) ->
        List.fold_left aux s es
    | If (e1, e2, e3) ->
        List.fold_left aux s [e1; e2; e3]
    | Let (v, e1, e2) ->
        if VarSet.mem v s then
          failwithf "uniquify: validate: variable %s bound more than once" v
        else
          let s1 = VarSet.add v s in
          List.fold_left aux s1 [e1; e2]
  in
  let _ = aux VarSet.empty e in
  ()

let uniquify (prog : program) : program =
  let (Program e) = prog in
  let ue = uniquify_exp e in
  let _ = validate ue in
  Program ue
