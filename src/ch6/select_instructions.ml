open Support
open Types
open Utils
module C = Ctup
open X86_var_global

(* NOTE: `fix_label` is needed for global variables as well as functions.
   MacOS, for instance, puts `_` before the names of both in assembly code. *)


let rec tail_instructions (i : C.tail) : instr list =
  failwith "TODO"

let convert_lt (lt : (Types.label * C.tail)) : Types.label * binfo1 block =
  let (lbl, tail) = lt in
  let block = Block (Binfo1, tail_instructions tail) in
    (lbl, block)

let convert_info (info : C.info) : info1 =
  let (C.Info { locals_types = vts }) = info in
    Info1 { locals_types = vts }

let select_instructions (prog : C.program) : (info1, binfo1) program =
  let (C.CProgram (info, lts)) = prog in
    X86Program (convert_info info, List.map convert_lt lts)

