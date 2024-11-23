open Support
open Types
open Lalloc_mon
module L = Lalloc_get

let fresh = Utils.make_gensym ()
let gen_temp_name () = fresh ~base:"$tmp" ~sep:"."

(* Convert an expression which needs to become atomic.
 * Return the atomic expression as well as a list of
 * names bound to complex operands. *)
let rec rco_atom (e : L.exp) : (var * exp) list * atm = failwith "TODO"
and rco_exp (e : L.exp) : exp = failwith "TODO"

let remove_complex_operands (prog : L.program) : program =
  let (L.Program exp) = prog in
  Program (rco_exp exp)
