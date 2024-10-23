open Support
open Support.Utils
open Types
open Lvar

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
    | Var sym ->
        if VarMap.mem sym map then Var (VarMap.find sym map) else Var sym
    | Int i -> Int i
    | Read -> Read
    | Negate exp -> Negate (un_helper exp map)
    | Add (exp1, exp2) ->
        let exp1 = un_helper exp1 map in
        let exp2 = un_helper exp2 map in
        Add (exp1, exp2)
    | Sub (exp1, exp2) ->
        let exp1 = un_helper exp1 map in
        let exp2 = un_helper exp2 map in
        Sub (exp1, exp2)
  in
  un_helper e VarMap.empty

let validate (e : exp) : unit =
  let rec aux (s : VarSet.t) (e : exp) : VarSet.t =
    match e with
    | Int _ | Var _ | Read -> s
    | Negate e1 -> aux s e1
    | Add (e1, e2) | Sub (e1, e2) ->
        let s1 = aux s e1 in
        aux s1 e2
    | Let (v, e1, e2) ->
        if VarSet.mem v s then
          failwithf "uniquify: validate: variable %s bound more than once" v
        else
          let s1 = VarSet.add v s in
          List.fold_left aux s1 [ e1; e2 ]
  in
  let _ = aux VarSet.empty e in
  ()

let uniquify (prog : program) : program =
  let (Program e) = prog in
  let ue = uniquify_exp e in
  let _ = validate ue in
  Program ue
