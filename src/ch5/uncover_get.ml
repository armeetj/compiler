open Types
open Lwhile_get
module L = Lwhile_shrink
module S = VarSet

let rec collect_set_vars (e : L.exp) : S.t =
  failwith "TODO"

let rec uncover_get_exp (s : S.t) (e : L.exp) : exp =
  failwith "TODO"

let uncover_get (prog : L.program) : program =
  let (L.Program e) = prog in
  let set_vars = collect_set_vars e in
  Program (uncover_get_exp set_vars e)
