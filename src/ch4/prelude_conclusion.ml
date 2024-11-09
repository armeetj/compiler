open Support
open Types
open Utils
module X = X86_if
open X86_asm

(* Code that has to be added to each program at the end. 
   It's parameterized on the stack space
   and the callee-save registers. *)
let epilog (callee_saves : RegSet.t) (ss : int) : instr list = 
  let main = fix_label "main" in
  failwith "TODO"


(* Convert a labeled block to a list of instructions. *)
let asm_of_lb (deref_adjust : int) (lb : label * X.block) : instr list =
  failwith "TODO"

let prelude_conclusion (prog : X.program) : program =
  let X.X86Program (info, lbs) = prog in
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

