open Types
open Lfun_ref
module L = Lfun_shrink

let rec reveal_functions_exp (fmap : int VarMap.t) (e : L.exp) : exp =
  let aux = reveal_functions_exp fmap in
  match e with
  | Void -> Void
  | Bool b -> Bool b
  | Int i -> Int i
  | Var v -> (
    match VarMap.find_opt v fmap with
    | Some arity -> FunRef (Label v, arity)
    | None -> Var v )
  | Prim (op, es) -> Prim (op, List.map aux es)
  | SetBang (v, e) -> SetBang (v, aux e)
  | Begin (es, e) -> Begin (List.map aux es, aux e)
  | If (cond, then_e, else_e) -> If (aux cond, aux then_e, aux else_e)
  | While (cond, body) -> While (aux cond, aux body)
  | Let (v, e1, e2) -> Let (v, aux e1, aux e2)
  | Vec (es, ty) -> Vec (List.map aux es, ty)
  | VecLen e -> VecLen (aux e)
  | VecRef (e, i) -> VecRef (aux e, i)
  | VecSet (v, i, e) -> VecSet (aux v, i, aux e)
  | Apply (f, args) -> Apply (aux f, List.map aux args)

let reveal_functions_def (fmap : int VarMap.t) (ldef : L.def) : def =
  let (L.Def (name, {args; ret; body})) = ldef in
  let body' = reveal_functions_exp fmap body in
  let fcont' = {args; ret; body = body'} in
  Def (Label name, fcont')

let get_name_arity (ldef : L.def) : var * int =
  let (L.Def (name, fcont)) = ldef in
  let args = fcont.args in
  (name, List.length args)

let reveal_functions (L.Program ds) =
  (* Extract all the function names and arities,
   * compute a map, and call `reveal_functions_def`
   * on the body of each definition. *)
  let fmap = VarMap.of_list (List.map get_name_arity ds) in
  Program (List.map (reveal_functions_def fmap) ds)
