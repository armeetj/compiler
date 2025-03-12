open Types
open Lfun_shrink
module L = Lfun

let rec shrink_exp (e : L.exp) : exp =
  match e with
  | And (e1, e2) -> If (shrink_exp e1, shrink_exp e2, Bool false)
  | Or (e1, e2) -> If (shrink_exp e1, Bool true, shrink_exp e2)
  | Bool e -> Bool e
  | Int e -> Int e
  | Var e -> Var e
  | Prim (co, el) -> Prim (co, List.map shrink_exp el)
  | If (e1, e2, e3) -> If (shrink_exp e1, shrink_exp e2, shrink_exp e3)
  | Let (v, e1, e2) -> Let (v, shrink_exp e1, shrink_exp e2)
  | While (e1, e2) -> While (shrink_exp e1, shrink_exp e2)
  | SetBang (v, e) -> SetBang (v, shrink_exp e)
  | Void -> Void
  | Begin (el, e) -> Begin (List.map shrink_exp el, shrink_exp e)
  | Vec (exp_lst, ty) -> Vec (List.map shrink_exp exp_lst, ty)
  | VecLen exp -> VecLen (shrink_exp exp)
  | VecSet (exp1, i, exp2) -> VecSet (shrink_exp exp1, i, shrink_exp exp2)
  | VecRef (exp, i) -> VecRef (shrink_exp exp, i)
  | Apply (e, el) -> Apply (shrink_exp e, List.map shrink_exp el)

let shrink_def (d : L.def) : def =
  let (L.Def (name, f)) = d in
  let body' = shrink_exp f.body in
  let f' = {args = f.args; ret = f.ret; body = body'} in
  Def (name, f')

let shrink (L.Program (ds, e)) =
  let ds' = List.map shrink_def ds in
  let e' = shrink_exp e in
  let d = Def ("main", {args = []; ret = Integer; body = e'}) in
  Program (d :: ds')
