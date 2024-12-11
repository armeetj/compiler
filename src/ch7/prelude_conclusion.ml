open Support
open Utils
open Types
open Alloc_utils
module X = X86_def
open X86_asm

let resize_initial_heap_size (n : int) : unit =
  begin
    if n < min_heap_size || n mod 8 <> 0 then
      failwithf "heap size must be divisible by 8 and >= %d" min_heap_size;
    init_heap_size := n
  end

(* Conclusion code that is common to both
   function conclusions and tail calls.
   Non-tail calls will add `Retq` at the end.
   Tail calls will add `TailJmp <arg>` *)
let conclusion_code (conclusion_params : RegSet.t * int * int) : instr list =
  let (callee_saves, ss, rs) = conclusion_params in
  let callee_save_list = RegSet.elements callee_saves in
  let reset_rootstack_ptr =
    [Subq (Imm (8 * rs), Reg R15)]
  in
  let reclaim_stack_space =
    [Addq (Imm ss, Reg Rsp)]
  in 
  let callee_save_pops =
    List.map (fun r -> Popq (Reg r)) (List.rev callee_save_list)
  in
    reset_rootstack_ptr @
    reclaim_stack_space @
    callee_save_pops @
    [Popq (Reg Rbp)]

(* Code that has to be added to each program at the end. 
   It's parameterized on the set of callee-save registers (`callee_saves`),
   the stack space (`ss`), and on the number of rootstack items (`rs`).
   We bundle these into the `conclusion_params` tuple
   because they are also used for computing code for tail calls elsewhere.
 *)
let epilog 
      (f_lbl : label)
      (conclusion_params : RegSet.t * int * int)
        : instr list = 
  let (callee_saves, ss, rs) = conclusion_params in
  let f_name  = string_of_label f_lbl in
  let is_main = f_name = "main" in
  failwith "TODO"


(* Convert a labeled block to a list of instructions. *)
let asm_of_lb
      (conclusion_params : RegSet.t * int * int)
      (deref_adjust : int)
      (lb : label * X.block)
        : instr list =
  failwith "TODO"

let prelude_conclusion_def (def : X.def) : instr list =
  (* Unpack the definition. *)
  let (Def (lbl, finfo, fcont)) = def in
  let X.{ body = lbs; _ } = fcont in
  let X.Finfo { num_spilled; num_spilled_root; used_callee } = finfo in
  let num_callees = RegSet.cardinal used_callee in

  (* Amount to shift all stack locations that are relative to %rbp: *)
  let deref_adjust = 8 * num_callees in
  let extra_stack_space =
    align_16 (8 * (num_spilled + num_callees)) - 8 * num_callees
  in
  let conclusion_params =
    (used_callee, extra_stack_space, num_spilled_root)
  in
  let ep = epilog lbl conclusion_params in
  let lbs' =
    List.concat_map
      (asm_of_lb conclusion_params deref_adjust)
      lbs
  in
    lbs' @ ep

let prelude_conclusion (prog : X.program) : program =
  let (X86Program defs) = prog in
    X86Program (List.concat_map prelude_conclusion_def defs)
