open Types
open Cif


(* Return all the (label, tail) pairs that are reachable
 * from the "start" label. *)
let process_blocks (lts : (label * tail) list) : (label * tail) list =
  failwith "TODO"

let remove_unused_blocks (prog : program) : program =
  let (CProgram (info, lts)) = prog in
    CProgram (info, process_blocks lts)
