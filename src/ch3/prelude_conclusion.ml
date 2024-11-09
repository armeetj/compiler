open Support
open Types
open Utils
module X = X86_int
open X86_asm

(* Code that has to be added to each program at the end. 
   It's parameterized on the stack space
   and the callee-save registers. *)
let epilog (callee_saves : RegSet.t) (ss : int) : instr list = 
  let main = fix_label "main" in
  [
    Global (Types.Label main);
    Label main;
    Pushq (Reg Rbp);
    Movq (Reg Rsp, Reg Rbp);] 
    @ List.map (fun reg -> Pushq (Reg reg)) (RegSet.elements callee_saves) @
  [ 
    Subq (Imm ss, Reg Rsp); 
    Jmp (Label "start");
    Label ("conclusion");
    Addq (Imm ss, Reg Rsp);
  ]
    @ List.map (fun reg -> Popq (Reg reg)) (List.rev (RegSet.elements callee_saves)) @
  [
    Popq (Reg Rbp);
    Retq;
  ]

let convert_arg a =
  match a with
  | X.Imm i -> Imm i
  | X.Reg r -> Reg r
  | X.Deref (r, i) -> Deref (r, i)
  
let offset arg deref_adjust = match arg with
  | Deref (r, curr) -> Deref (r, curr - deref_adjust)
  | arg -> arg

let adjust_stack_access instr deref_adjust =
  match instr with
  | X.Addq (a1, a2) -> Addq (offset (convert_arg a1) deref_adjust, offset (convert_arg a2) deref_adjust)
  | X.Subq (a1, a2) -> Subq (offset (convert_arg a1) deref_adjust, offset (convert_arg a2) deref_adjust)
  | X.Movq (a1, a2) -> Movq (offset (convert_arg a1) deref_adjust, offset (convert_arg a2) deref_adjust)
  | X.Negq a -> Negq (offset (convert_arg a) deref_adjust)
  | X.Pushq a -> Pushq (offset (convert_arg a) deref_adjust)
  | X.Popq a -> Popq (offset (convert_arg a) deref_adjust)
  | X.Callq (l, _) -> Callq l
  | X.Retq -> Retq
  | X.Jmp l -> Jmp l

let rec instrs_of_block (b : X.instr list) deref_adjust : instr list = 
  match b with
  | [] -> []
  | h :: t -> [adjust_stack_access h deref_adjust] @ (instrs_of_block t deref_adjust)

(* Convert a labeled block to a list of instructions. *)
let asm_of_lb (deref_adjust : int) (lb : label * X.block) : instr list =
  let Label l, X.Block b = lb in Label l :: (instrs_of_block b deref_adjust)

let prelude_conclusion (X.X86Program (info, lbs)) =
  let X.Info { num_spilled; used_callee; _ } = info in
  let num_callees = RegSet.cardinal used_callee in
  (* Amount to shift all stack locations that are relative to %rbp: *)
  let deref_adjust = 8 * num_callees in
  let extra_stack_space =
    align_16 (8 * (num_spilled + num_callees)) - 8 * num_callees
  in
  let ep = epilog used_callee extra_stack_space in
  let lbs' = List.concat_map (asm_of_lb deref_adjust) lbs in
    X86Program (lbs' @ ep)