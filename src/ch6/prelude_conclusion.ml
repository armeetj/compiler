open Support
open Utils
open Types
open Alloc_utils
module X = X86_global
open X86_asm

let resize_initial_heap_size (n : int) : unit =
  if n < min_heap_size || n mod 8 <> 0 then
    failwithf "heap size must be divisible by 8 and >= %d" min_heap_size ;
  init_heap_size := n

(* Code that has to be added to each program at the end.
   It's parameterized on the set of callee-save registers (`callee_saves`),
   the stack space (`ss`), and on the number of rootstack items (`rs`). *)
let epilog (callee_saves : RegSet.t) (ss : int) (rs : int) : instr list =
  let main = fix_label "main" in
  failwith "TODO"

(* Convert a labeled block to a list of instructions. *)
let asm_of_lb (deref_adjust : int) (lb : label * X.block) : instr list =
  failwith "TODO"

let prelude_conclusion (prog : X.program) : program =
  let (X.X86Program (info, lbs)) = prog in
  let (X.Info {num_spilled; num_spilled_root; used_callee; _}) = info in
  let num_callees = RegSet.cardinal used_callee in
  (* Amount to shift all stack locations that are relative to %rbp: *)
  let deref_adjust = 8 * num_callees in
  let extra_stack_space =
    align_16 (8 * (num_spilled + num_callees)) - (8 * num_callees)
  in
  let ep = epilog used_callee extra_stack_space num_spilled_root in
  let lbs' = List.concat_map (asm_of_lb deref_adjust) lbs in
  X86Program (lbs' @ ep)
