open Types
open Cfun


(* Return all the (label, tail) pairs that are reachable
   from the "start" label. *)
let process_blocks (lts : (label * tail) list) : (label * tail) list =
  failwith "TODO"

let remove_unused_blocks_def (d : def) : def =
  let Def (lbl, fcont) = d in
  let { args; ret; locals; body } = fcont in
  let body' = process_blocks body in
    Def (lbl, { args; ret; locals; body = body' })

let remove_unused_blocks (prog : program) : program =
  let (CProgram defs) = prog in
    CProgram (List.map remove_unused_blocks_def defs)

