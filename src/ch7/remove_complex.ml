open Support
open Types
open Lfun_ref_mon

module L = Lfun_ref_alloc_get

let fresh = Utils.make_gensym ()
let gen_temp_name () = fresh ~base:"$tmp" ~sep:"."
(* A special name for binding to forms that return `Void`. *)
let temp_void_name = "$_"


(* Convert an expression which needs to become atomic.
 * Return the atomic expression as well as a list of
 * names bound to complex operands. *)
let rec rco_atom (e : L.exp) : ((var * exp) list) * atm =
  failwith "TODO"

and rco_exp (e : L.exp) : exp =
  failwith "TODO"

let rco_def (d : L.def) : def =
  let L.Def (name, { args; ret; body }) = d in
  let body' = rco_exp body in
    Def (name, { args; ret; body = body' })

let remove_complex_operands (L.Program defs) =
  let defs' = List.map rco_def defs in
    Program defs'

