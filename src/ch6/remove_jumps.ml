open Support
open Utils
open Types
open X86_var_global
module M = LabelMap
module G = LabelDgraph

(*

Algorithm:

- Convert the (label, block) list into a label graph
  (a directed graph, using the `LabelDgraph` module).
- Find all blocks which have only a single out edge.
- If the target of these out edges has only a single in edge,
    merge the two blocks.
- Repeat until there are no more mergeable blocks.

*)

(* Get a list of all the jump labels in a block.
   NOTE: This is not the same as the similarly-named function
   from the `Ctup` module. *)
let get_jump_labels (Block (_, instrs) : 'a block) : label list =
  failwith "TODO"

let make_graph (lbs : (label * 'a block) list) : LabelDgraph.t = failwith "TODO"

(* Get a pair of mergeable labels from the graph if there are any. *)
let get_mergeable_labels (g : G.t) : (label * label) option = failwith "TODO"

(* Merge two blocks. *)
let merge_blocks (b1 : 'a block) (b2 : 'a block) : 'a block = failwith "TODO"

(* Merge two blocks A and B if block A only jumps to block B
   and block B is only jumped to from block A.
   The merged block will have the label of the original block A. *)
let process_blocks (lbs : (label * 'a block) list) : (label * 'a block) list =
  if List.length lbs < 2 then lbs (* no blocks to merge! *) else failwith "TODO"

let remove_jumps (prog : ('a, binfo1) program) : ('a, binfo1) program =
  let (X86Program (info, lbs)) = prog in
  X86Program (info, process_blocks lbs)
