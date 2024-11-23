(* ch5 *)
open Lwhile_shrink
module L = Lwhile

let rec shrink_exp (e : L.exp) : exp =
  match e with
  | And (e1, e2) ->
      If (shrink_exp e1, shrink_exp e2, Bool false)
  | Or (e1, e2) ->
      If (shrink_exp e1, Bool true, shrink_exp e2)
  | Bool e ->
      Bool e
  | Int e ->
      Int e
  | Var e ->
      Var e
  | Prim (co, el) ->
      Prim (co, List.map (fun e -> shrink_exp e) el)
  | If (e1, e2, e3) ->
      If (shrink_exp e1, shrink_exp e2, shrink_exp e3)
  | Let (v, e1, e2) ->
      Let (v, shrink_exp e1, shrink_exp e2)
  | While (e1, e2) ->
      While (shrink_exp e1, shrink_exp e2)
  | SetBang (v, e) ->
      SetBang (v, shrink_exp e)
  | Void ->
      Void
  | Begin (el, e) ->
      Begin (List.map (fun exp -> shrink_exp exp) el, shrink_exp e)

let shrink (prog : L.program) : program =
  let (L.Program e) = prog in
  Program (shrink_exp e)
