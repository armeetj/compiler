open Support
open Lfun_ref_alloc
module L = Lfun_ref

let fresh = Utils.make_gensym ()
let new_var () = fresh ~base:"$ea" ~sep:"."
let new_void_var () = fresh ~base:"_" ~sep:"."

let expose_allocation_exp (e : L.exp) : exp =
  failwith "TODO"

let expose_allocation_def (ldef : L.def) =
  let (Def (name, { args; ret; body })) = ldef in
  let body'  = expose_allocation_exp body in
  let fcont' = { args; ret; body = body' } in
    Def (name, fcont')

let expose_allocation (L.Program ds) =
  Program (List.map expose_allocation_def ds)
