open Support
open Types
open Utils
module X = X86_var_global

(* Flag; when true, extra debugging information is printed. *)
let _debug = ref false

let rflags_reg = X.Reg Rflags

(* Compute the live sets for the instructions of a single labeled block.
 * The `live_before_map` is the live-before sets for each block named
 * by the given labels. *)
let uncover_live_in_block (live_before_map : LocSet.t LabelMap.t)
  (instrs : X.instr list) : X.live =
  failwith "TODO"

(* Get the next jump labels, if any.
 * The jump instructions should only be at the end of the block,
 * but we can accumulate all of them, since you can have two
 * jumps at the end (one conditional, one not). *)
let get_next_labels (block : 'a X.block) : LabelSet.t =
  let (X.Block (_, instrs)) = block in
  failwith "TODO"

(* Liveness algorithm (dataflow analysis, but not generic):
 * - Create an empty (imperative) queue.
 * - Create an initial liveness map from labels to empty locsets
 *   (except for the "conclusion" label, which has a fixed set of registers).
 * - Add all the labels (except "conclusion") to a queue.
 * - Repeat until the queue is empty:
 *   - Pop a label off the queue.
 *   - Get the instructions corresponding to the label.
 *   - Use the liveness map to get the old live-before set for the instructions.
 *   - Compute the new live-before set for the instructions.
 *   - If the live-before set has changed:
 *     - Update the liveness map.
 *     - Find the labels of the blocks that project to the current label's
 *       block, and add them to the queue.
 * - Return the liveness map.
 * NOTE: Make sure to never add the label "conclusion" to the queue!
 * It has no corresponding instructions.
 *)
let compute_liveness (g : LabelDgraph.t) (imap : X.instr list LabelMap.t) :
  LocSet.t LabelMap.t =
  failwith "TODO"

let uncover_live (prog : (X.info1, X.binfo1) X.program) :
  (X.info1, X.binfo2) X.program =
  let (X.X86Program (info, lbs)) = prog in
  (* Generate the control-flow graph from the (label, block) pairs. *)
  let cfg =
    LabelDgraph.of_alist lbs (fun bl -> LabelSet.elements (get_next_labels bl))
  in
  (* Create a label->instrs map. *)
  let (imap : X.instr list LabelMap.t) =
    lbs
    |> List.map (fun (lbl, X.Block (_, instrs)) -> (lbl, instrs))
    |> LabelMap.of_list
  in
  (* Compute all the live-before sets. *)
  let (live_before_sets : LocSet.t LabelMap.t) = compute_liveness cfg imap in
  (* We run the liveness computation one last time after computing
   * all the live-before sets to get the full liveness information
   * for a block.  This is a little inefficient; we could generate it
   * in the `compute_liveness` function while computing the
   * live-before sets and return that directly.
   * IMO this is a bit cleaner and easier to debug. *)
  let get_live (lbl : label) : X.live =
    let instrs =
      LabelMap.find_or_fail lbl imap
        ~err_msg:
          (Printf.sprintf "uncover_live: no instructions for label (%s)"
             (string_of_label lbl) )
    in
    uncover_live_in_block live_before_sets instrs
  in
  (* Rewrite the label/block information with new block info containing
   * the liveness information. *)
  let lbs' =
    List.map
      (fun (lbl, X.Block (_, instrs)) ->
        let b = X.Binfo2 (get_live lbl) in
        (lbl, X.Block (b, instrs)) )
      lbs
  in
  X.X86Program (info, lbs')
