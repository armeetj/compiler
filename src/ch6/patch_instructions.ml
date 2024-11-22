open Sexplib
open Support.Utils
open Types
open X86_global
module X = X86_var_global


let convert_block (b : X.binfo1 X.block) : block =
  failwith "TODO"

let convert_info (i : X.info3) : info =
  let (X.Info3 info) = i in
  Info
    { locals_types     = info.locals_types;
      num_spilled      = info.num_spilled;
      num_spilled_root = info.num_spilled_root;
      used_callee      = info.used_callee }

let patch_instructions (prog : (X.info3, X.binfo1) X.program) : program =
  let (X.X86Program (info, lbs)) = prog in
  let info' = convert_info info in
  let lbs' = List.map (fun (lbl, block) -> (lbl, convert_block block)) lbs in
  X86Program (info', lbs')
