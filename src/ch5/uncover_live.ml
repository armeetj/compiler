open Support
open Types
open Utils
module X = X86_var_loop

(* WILL DO IN REWORK *)

let rec read_set lst set =
  match lst with
  | [] ->
      set
  | h :: t -> (
    match h with
    | X.Var v ->
        LocSet.add (VarL v) (read_set t set)
    | X.Reg r ->
        LocSet.add (RegL r) (read_set t set)
    | _ ->
        read_set t set )

(* takes in list of args and removes the useful ones from the set *)
let rec write_set lst set =
  match lst with
  | [] ->
      set
  | h :: t -> (
    match h with
    | X.Var v ->
        LocSet.remove (VarL v) (write_set t set)
    | X.Reg r ->
        LocSet.remove (RegL r) (write_set t set)
    | _ ->
        write_set t set )

let list_of_regset st = List.map (fun x -> X.Reg x) (RegSet.elements st)

(* Flag; when true, extra debugging information is printed. *)
let _debug = ref false

let rflags_reg = X.Reg Rflags

(* Compute the live sets for the instructions of a single labeled block. *)
let uncover_live_in_block (label_map : LocSet.t LabelMap.t)
    (instrs : X.instr list) : X.live =
  (* computes l_before given current instruction and l_after in a set *)
  let l_before instr (l_after : LocSet.t) =
    match instr with
    | X.Addq (arg1, arg2) ->
        read_set [arg1; arg2] l_after
    | X.Subq (arg1, arg2) ->
        read_set [arg1; arg2] l_after
    | X.Negq arg ->
        read_set [arg] l_after
    | X.Movq (arg1, arg2) ->
        read_set [arg1] (write_set [arg2] l_after)
    | X.Movzbq (arg1, arg2) ->
        read_set [arg1] (write_set [arg2] l_after)
    | X.Pushq _ ->
        l_after
    | X.Popq arg ->
        read_set [arg] l_after
    | X.Retq ->
        read_set [X.Reg Rax] l_after
    (* remove (write) from caller and then add first i of callee, as according to spec*)
    | X.Callq (_, i) ->
        read_set
          (take i (list_of_regset callee_save_regs))
          (write_set (list_of_regset caller_save_regs) l_after)
    | X.Jmp label ->
        let args =
          List.map
            (function
              | x -> (
                match x with
                | VarL v ->
                    X.Var v
                | RegL r ->
                    X.Reg r
                | _ ->
                    failwith "Shouldn't have this case" ) )
            (LocSet.elements (LabelMap.find label label_map))
        in
        read_set args l_after
    | X.Xorq (arg1, arg2) ->
        read_set [arg1; arg2] l_after
    | X.Cmpq (arg1, arg2) ->
        read_set [arg1; arg2] (write_set [rflags_reg] l_after)
    | X.Set (_, arg) ->
        read_set [Reg Rflags] (write_set [arg] l_after)
    | X.JmpIf (_, label) ->
        let args =
          List.map
            (function
              | x -> (
                match x with
                | VarL v ->
                    X.Var v
                | RegL r ->
                    X.Reg r
                | _ ->
                    failwith "Shouldn't have this case" ) )
            (LocSet.elements (LabelMap.find label label_map))
        in
        read_set (rflags_reg :: args) l_after
  in
  (* takes in first instruction in instructions and adds L_before to acc*)
  let process instr acc =
    match acc with
    (*returns acc with new value*)
    | h :: _ ->
        l_before instr h :: acc
    | _ ->
        failwith "Shouldn't have this case"
  in
  (* actual recursive creation of final list *)
  let rec helper instrs_left acc =
    match instrs_left with
    | [] ->
        acc
    | instr :: tail ->
        helper tail (process instr acc)
    (* reverse instructions to allow recurrence L_after(k) = L_before(k+1)*)
  in
  match helper (List.rev instrs) [LocSet.empty] with
  | h :: t ->
      {initial = h; afters = t}
  | _ ->
      failwith "no code?"

(* Get the next jump labels, if any.
 * The jump instructions should only be at the end of the block,
 * but we can accumulate all of them, since you can have two
 * jumps at the end (one conditional, one not). *)
let get_next_labels (block : 'a X.block) : LabelSet.t =
  let (X.Block (_, instrs)) = block in
  List.fold_right
    (fun instr acc ->
      match instr with
      | X.Jmp lbl | X.JmpIf (_, lbl) ->
          LabelSet.add lbl acc
      | _ ->
          acc )
    instrs LabelSet.empty

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
  let q = Queue.create () in
  let init_map =
    LabelMap.mapi (fun _ _ -> LocSet.empty) imap
    |> LabelMap.add (Label "conclusion") (LocSet.of_list [RegL Rax; RegL Rsp])
  in
  let _ =
    LabelMap.iter
      (fun lbl _ -> if lbl <> Label "conclusion" then Queue.add lbl q)
      init_map
  in
  let rec helper map =
    if Queue.is_empty q then map
    else
      let lbl = Queue.take q in
      let instr = LabelMap.find lbl imap in
      let o_lbs = LabelMap.find lbl map in
      let n_lbs = uncover_live_in_block map instr in
      if not (LocSet.equal o_lbs n_lbs.initial) then (
        let updated_map = LabelMap.add lbl n_lbs.initial map in
        let predecessors = LabelDgraph.neighbors_in g lbl in
        List.iter (fun pred_lbl -> Queue.add pred_lbl q) predecessors ;
        helper updated_map )
      else helper map
  in
  helper init_map

let uncover_live (prog : (X.info1, X.binfo1) X.program) :
    (X.info1, X.binfo2) X.program =
  let (X.X86Program (info, lbs)) = prog in
  (* Generate the control-flow graph from the (label, block) pairs. *)
  let cfg =
    LabelDgraph.of_alist lbs (fun bl ->
        get_next_labels bl |> LabelSet.elements )
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
