open Sexplib
open Support.Utils
open Types
open X86_def
module X = X86_var_def


let convert_block (b : X.binfo1 X.block) : block =
  failwith "TODO"

let convert_info (i : X.finfo3) : finfo =
  let (X.Finfo3 finfo) = i in
    Finfo
      { num_spilled      = finfo.num_spilled;
        num_spilled_root = finfo.num_spilled_root;
        used_callee      = finfo.used_callee }

let patch_instructions_def (def : (X.finfo3, X.binfo1) X.def) : def =
  (* Unpack the labeled block list (`lbs`) from a definition. *)
  let X.(Def (lbl, finfo, fcont)) = def in
  let X.{ nparams; locals; body = lbs } = fcont in

  (* Patch the instructions. *)
  let lbs' = List.map (fun (lbl, block) -> (lbl, convert_block block)) lbs in

  (* Put the definition back together. *)
  let fcont' = { nparams; locals; body = lbs' } in
  let finfo' = convert_info finfo in
    Def (lbl, finfo', fcont')

let patch_instructions
    (prog : (X.finfo3, X.binfo1) X.program) : program =
  let (X86Program defs) = prog in
    X86Program (List.map patch_instructions_def defs)
