open Types
open Lfun_ref

module L = Lfun_shrink

let rec reveal_functions_exp (fmap: int VarMap.t) (e : L.exp) : exp =
  failwith "TODO"

let reveal_functions_def (fmap : int VarMap.t) (ldef : L.def) : def =
  let (L.Def (name, { args; ret; body } )) = ldef in
  let body'  = reveal_functions_exp fmap body in
  let fcont' = { args; ret; body = body' } in
    Def (Label name, fcont')

let get_name_arity (ldef : L.def) : var * int =
  let (L.Def (name, fcont)) = ldef in
  let args = fcont.args in
    (name, List.length args)

let reveal_functions (L.Program ds) =
  (* Extract all the function names and arities,
   * compute a map, and call `reveal_functions_def`
   * on the body of each definition. *)
  let fmap =
    VarMap.of_list (List.map get_name_arity ds)
  in
    Program (List.map (reveal_functions_def fmap) ds)
