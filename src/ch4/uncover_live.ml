open Support
open Types
open Utils

module X = X86_var_if

let rflags_reg = X.Reg Rflags


(* Compute the live sets for the instructions of a single labeled block.
 * The `live_before_map` is the live-before sets for each block named
 * by the given labels. *)
let uncover_live_in_block
      (live_before_map : LocSet.t LabelMap.t) (instrs : X.instr list)
        : X.live =
  failwith "TODO"

(* Get the next jump labels, if any.
 * The jump instructions should only be at the end of the block,
 * but we can accumulate all of them, since you can have two
 * jumps at the end (one conditional, one not). *)
let get_next_labels (block : 'a X.block) : LabelSet.t =
  let (X.Block (_, instrs)) = block in
  failwith "TODO"

(* Find the correct order of the labels for liveness analysis.
 * Algorithm:
 * 1) Compute the next labels for each block.
 * 2) Use the block labels and next labels to define a list of CFG edges.
 * 3) Filter out any edges that have "conclusion" as their target.
 *    a) If the graph has no edges, it should only have one label;
 *       return a singleton list of that label.
 *    b) Otherwise:
 *       1) Construct a label graph from the list of edges.
 *       2) Do a topological sort of the transpose of the graph. *)
let order_labels (lbs : (label * 'a X.block) list) : label list =
  failwith "TODO"

let uncover_live
    (prog : (X.info1, X.binfo1) X.program) : (X.info1, X.binfo2) X.program =
  let (X.X86Program (info, lbs)) = prog in
  let labels_ordered = order_labels lbs in
  (* `live_before_labels` is a map from labels to live-before sets,
   * for the benefit of any `jmp` instructions.
   * To start with, there is only one relevant label: `conclusion`. *)
  let (live_before_labels : LocSet.t LabelMap.t) =
    let concset = LocSet.of_list [RegL Rax; RegL Rsp] in
      LabelMap.singleton (Label "conclusion") concset
  in
  let lbs_map = LabelMap.of_list lbs in
  (* Go through the labels in the correct order and
   * 1) extract the instructions for the label,
   * 2) compute the liveness data for the instructions,
   * 3) compute the new info field and the new block,
   *    and add it to the new label/block map,
   * 4) and update the live_before_labels for future labels.
   *)
  let (_, lbs_map') =
    List.fold_left
      (fun (live_before_labels_prev, new_lbs_map) lbl ->
         failwith "TODO")
      (live_before_labels, LabelMap.empty)
      labels_ordered
  in
  let lbs' = LabelMap.bindings lbs_map' in
    X.X86Program (info, lbs')

