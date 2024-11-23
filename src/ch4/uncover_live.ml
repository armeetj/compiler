open Support
open Types
open Utils
module X = X86_var_if

let rflags_reg = X.Reg Rflags

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

let rec first_i i lst =
  match (i, lst) with
  | 0, _ ->
      []
  | _, [] ->
      []
  | _, h :: t ->
      h :: first_i (i - 1) t

let list_of_regset st = List.map (fun x -> X.Reg x) (RegSet.elements st)

(* Compute the live sets for the instructions of a single labeled block.
 * The `live_before_map` is the live-before sets for each block named
 * by the given labels. *)
let uncover_live_in_block (live_before_map : LocSet.t LabelMap.t)
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
    | X.Pushq _ ->
        l_after
    | X.Popq arg ->
        read_set [arg] l_after
    | X.Retq ->
        read_set [X.Reg Rax] l_after
    (* remove (write) from caller and then add first i of callee, as according to spec*)
    | X.Callq (_, i) ->
        read_set
          (first_i i (list_of_regset callee_save_regs))
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
            (LocSet.elements (LabelMap.find label live_before_map))
        in
        read_set args l_after
    | X.Xorq (arg1, arg2) ->
        read_set [arg1; arg2] l_after
    | X.Cmpq (arg1, arg2) ->
        read_set [arg1; arg2] l_after
    | X.Set (_, arg) ->
        write_set [arg] l_after
    | X.Movzbq (arg1, arg2) ->
        read_set [arg1] (write_set [arg2] l_after)
    | _ ->
        failwith "JmpIf not implemented"
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
  let rec helper instrs labels =
    match instrs with
    | [] ->
        labels
    | instr :: t -> (
      match instr with
      | X.Jmp label | X.JmpIf (_, label) ->
          helper t (LabelSet.add label labels)
      | _ ->
          helper t labels )
  in
  helper instrs LabelSet.empty

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

let uncover_live (prog : (X.info1, X.binfo1) X.program) :
    (X.info1, X.binfo2) X.program =
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
  let _, lbs_map' =
    List.fold_left
      (fun (live_before_labels_prev, new_lbs_map) lbl -> failwith "TODO")
      (live_before_labels, LabelMap.empty)
      labels_ordered
  in
  let lbs' = LabelMap.bindings lbs_map' in
  X.X86Program (info, lbs')
