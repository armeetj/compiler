open Ltup_shrink
module L = Ltup

let rec shrink_exp (e : L.exp) : exp =
  failwith "TODO"

let shrink (prog : L.program) : program =
  let (L.Program e) = prog in
  Program (shrink_exp e)
