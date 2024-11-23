open Support
open Utils
open Types
open X86_var_if
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
   from the `Cif` module. *)
let get_jump_labels (Block (_, instrs) : 'a block) : label list =
  let rec helper instrs =
    match instrs with
    | [] ->
        []
    | Jmp l :: rest ->
        l :: helper rest
    | JmpIf (_, l) :: rest ->
        l :: helper rest
    | _ :: rest ->
        helper rest
  in
  helper instrs

let make_graph (lbs : (label * 'a block) list) : LabelDgraph.t =
  let rec add_vertices lbs g =
    match lbs with
    | [] ->
        g
    | (l, _) :: t ->
        add_vertices t (if l <> Label "conclusion" then G.add_vertex g l else g)
  in
  let rec add_edges lbs g =
    match lbs with
    | [] ->
        g
    | (l1, b1) :: t ->
        let rec add_edges_from_label labels g =
          match labels with
          | [] ->
              g
          | l2 :: t ->
              add_edges_from_label t
                (if l2 <> Label "conclusion" then G.add_edge g l1 l2 else g)
        in
        add_edges t (add_edges_from_label (get_jump_labels b1) g)
  in
  add_edges lbs (add_vertices lbs G.empty)

(* Get a pair of mergeable labels from the graph if there are any. *)
let get_mergeable_labels (g : G.t) : (label * label) option =
  let rec find_mergeable vs =
    match vs with
    | [] ->
        None
    | l :: rest -> (
      match G.neighbors_out g l with
      | [ele] -> (
        match G.neighbors_in g ele with
        | [l] ->
            Some (l, ele)
        | _ ->
            find_mergeable rest )
      | _ ->
          find_mergeable rest )
  in
  find_mergeable (G.vertices g)

(* Merge two blocks. *)
let merge_blocks (b1 : 'a block) (b2 : 'a block) : 'a block =
  let (Block (info1, instrs1)) = b1 in
  let (Block (_, instrs2)) = b2 in
  let instrs1_butlast = butlast instrs1 in
  Block (info1, instrs1_butlast @ instrs2)

(* Merge two blocks A and B if block A only jumps to block B
   and block B is only jumped to from block A.
   The merged block will have the label of the original block A. *)
let process_blocks (lbs : (label * 'a block) list) : (label * 'a block) list =
  if List.length lbs < 2 then lbs (* no blocks to merge! *)
  else
    let lbm = List.fold_left (fun m (l, b) -> M.add l b m) M.empty lbs in
    let rec process lbm g =
      match get_mergeable_labels g with
      | None ->
          M.bindings lbm
      | Some (l1, l2) ->
          let merged_block = merge_blocks (M.find l1 lbm) (M.find l2 lbm) in
          let new_g = G.merge_vertices g l1 l2 in
          process (M.add l1 merged_block (M.remove l2 lbm)) new_g
    in
    let g = make_graph lbs in
    process lbm g

let remove_jumps (prog : ('a, binfo1) program) : ('a, binfo1) program =
  let (X86Program (info, lbs)) = prog in
  X86Program (info, process_blocks lbs)
