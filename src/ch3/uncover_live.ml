open Support.Utils
open Types
module X = X86_var

(* takes in list of args and adds the useful ones to the set *)
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
    | X.Pushq _ ->
        l_after
    | X.Popq arg ->
        read_set [arg] l_after
    | X.Retq ->
        read_set [X.Reg Rax] l_after
    (* remove (write) from caller and then add first i of callee, as according to spec *)
    | X.Callq (_, i) ->
        read_set
          (take i (list_of_regset callee_save_regs))
          (write_set (list_of_regset caller_save_regs) l_after)
    | X.Jmp label ->
        let args =
          List.map
            (function
               | VarL v ->
                   X.Var v
               | RegL r ->
                   X.Reg r
               | _ ->
                   failwith "Shouldn't have this case" )
            (LocSet.elements (LabelMap.find label label_map))
        in
        read_set args l_after
  in
  (* takes in first instruction in instructions and adds L_before to acc *)
  let process instr acc =
    match acc with
    (* returns acc with new value *)
    | h :: _ ->
        l_before instr h :: acc
    | _ ->
        failwith "process: shouldn't have this case"
  in
  (* actual recursive creation of final list *)
  let rec helper instrs_left acc =
    match instrs_left with
    | [] ->
        acc
    | instr :: tail ->
        helper tail (process instr acc)
    (* reverse instructions to allow recurrence L_after(k) = L_before(k+1) *)
  in
  match helper (List.rev instrs) [LocSet.empty] with
  | h :: t ->
      {initial = h; afters = t}
  | _ ->
      failwith "no code?"

let uncover_live (prog : (X.info1, X.binfo1) X.program) :
    (X.info1, X.binfo2) X.program =
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
        (lbl, block') )
      lbs
  in
  X.X86Program (info, lbs')
