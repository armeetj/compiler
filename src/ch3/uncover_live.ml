open Support
open Types
open Utils

module X = X86_var


(* Compute the live sets for the instructions of a single labeled block. *)
let uncover_live_in_block
      (label_map : LocSet.t LabelMap.t) (instrs : X.instr list) : X.live =
  failwith "TODO"

let uncover_live
      (prog : (X.info1, X.binfo1) X.program)
      : (X.info1, X.binfo2) X.program =
  let (X.X86Program (info, lbs)) = prog in
  (* `live_before_labels` is a map from labels to live-before sets,
   * for the benefit of any `jmp` instructions.
   * Here there is only one relevant label: `conclusion`.
   * We assume that the conclusion uses the registers %rax and %rsp. *)
  let (live_before_labels : LocSet.t LabelMap.t) =
    let concset = LocSet.of_list [RegL Rax; RegL Rsp] in
      LabelMap.singleton (Label "conclusion") concset
  in
  let (lbs' : (label * X.binfo2 X.block) list) =
    List.map
      (fun (lbl, block) ->
         let (X.Block (_, instrs)) = block in
         let live = uncover_live_in_block live_before_labels instrs in
         let block' = X.Block (X.Binfo2 live, instrs) in
           (lbl, block'))
      lbs
  in
    X.X86Program (info, lbs')
