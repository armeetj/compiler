open Support
open Lalloc
module L = Ltup_shrink

let fresh = Utils.make_gensym ()

(* Generate a fresh name to bind to an arbitrary expression. *)
let new_var () = fresh ~base:"$ea" ~sep:"."

(* Generate a fresh name to bind to an expression
   whose type is always `Void`. *)
let new_void_var () = fresh ~base:"_" ~sep:"."

let expose_allocation_exp (e : L.exp) : exp = failwith "TODO"

let expose_allocation (prog : L.program) : program =
  let (L.Program e) = prog in
  Program (expose_allocation_exp e)
