open Support
open Utils
open Types
open Alloc_utils
module X = X86_def
open X86_asm

let resize_initial_heap_size (n : int) : unit =
  if n < min_heap_size || n mod 8 <> 0 then
    failwithf "heap size must be divisible by 8 and >= %d" min_heap_size ;
  init_heap_size := n

(* Conclusion code that is common to both
   function conclusions and tail calls.
   Non-tail calls will add `Retq` at the end.
   Tail calls will add `TailJmp <arg>` *)
let conclusion_code (conclusion_params : RegSet.t * int * int) : instr list =
  let callee_saves, ss, rs = conclusion_params in
  let callee_save_list = RegSet.elements callee_saves in
  let reset_rootstack_ptr = [Subq (Imm (8 * rs), Reg R15)] in
  let reclaim_stack_space = [Addq (Imm ss, Reg Rsp)] in
  let callee_save_pops =
    List.map (fun r -> Popq (Reg r)) (List.rev callee_save_list)
  in
  reset_rootstack_ptr @ reclaim_stack_space @ callee_save_pops @ [Popq (Reg Rbp)]

(* Code that has to be added to each program at the end.
   It's parameterized on the set of callee-save registers (`callee_saves`),
   the stack space (`ss`), and on the number of rootstack items (`rs`).
   We bundle these into the `conclusion_params` tuple
   because they are also used for computing code for tail calls elsewhere.
*)
let epilog (f_lbl : label) (conclusion_params : RegSet.t * int * int) :
  instr list =
  let callee_saves, ss, rs = conclusion_params in
  let f_name = string_of_label f_lbl in
  let is_main = f_name = "main" in
  [ Global (Types.Label f_name)
  ; Align 8
  ; Label f_name
  ; Pushq (Reg Rbp)
  ; Movq (Reg Rsp, Reg Rbp) ]
  @ List.map (fun reg -> Pushq (Reg reg)) (RegSet.elements callee_saves)
  @ [Subq (Imm ss, Reg Rsp)]
  @ ( if is_main then
        [ Movq (Imm !init_heap_size, Reg Rdi)
        ; Movq (Imm !init_heap_size, Reg Rsi)
        ; Callq (Label (fix_label "initialize"))
        ; Movq (GlobalArg (Rip, Label (fix_label "rootstack_begin")), Reg R15)
        ]
      else [] )
  @ List.init rs (fun i -> Movq (Imm 0, Deref (R15, i * 8)))
  @ [ Addq (Imm (rs * 8), Reg R15)
    ; Jmp (Label (fix_label (f_name ^ "_start")))
    ; Label (fix_label (f_name ^ "_conclusion"))
    ; Subq (Imm (rs * 8), Reg R15)
    ; Addq (Imm ss, Reg Rsp) ]
  @ List.map
      (fun reg -> Popq (Reg reg))
      (List.rev (RegSet.elements callee_saves))
  @ [Popq (Reg Rbp); Retq]

let convert_arg a =
  match a with
  | X.Imm i -> Imm i
  | X.Reg r -> Reg r
  | X.Deref (r, i) -> Deref (r, i)
  | X.ByteReg b -> ByteReg b
  | X.GlobalArg (Label l) -> GlobalArg (Rip, Label (fix_label l))

let offset arg deref_adjust =
  match arg with
  | Deref (r, curr) -> (
    match r with
    | Rbp -> Deref (r, curr - deref_adjust)
    | _ -> Deref (r, curr) )
  | arg -> arg

let adjust_stack_access conclusion_params instr deref_adjust =
  match instr with
  | X.Addq (a1, a2) ->
    [ Addq
        ( offset (convert_arg a1) deref_adjust
        , offset (convert_arg a2) deref_adjust ) ]
  | X.Subq (a1, a2) ->
    [ Subq
        ( offset (convert_arg a1) deref_adjust
        , offset (convert_arg a2) deref_adjust ) ]
  | X.Negq a -> [Negq (offset (convert_arg a) deref_adjust)]
  | X.Xorq (a1, a2) ->
    [ Xorq
        ( offset (convert_arg a1) deref_adjust
        , offset (convert_arg a2) deref_adjust ) ]
  | X.Cmpq (a1, a2) ->
    [ Cmpq
        ( offset (convert_arg a1) deref_adjust
        , offset (convert_arg a2) deref_adjust ) ]
  | X.Set (cc, a) -> [Set (cc, offset (convert_arg a) deref_adjust)]
  | X.Movq (a1, a2) ->
    [ Movq
        ( offset (convert_arg a1) deref_adjust
        , offset (convert_arg a2) deref_adjust ) ]
  | X.Movzbq (a1, a2) ->
    [ Movzbq
        ( offset (convert_arg a1) deref_adjust
        , offset (convert_arg a2) deref_adjust ) ]
  | X.Pushq a -> [Pushq (offset (convert_arg a) deref_adjust)]
  | X.Popq a -> [Popq (offset (convert_arg a) deref_adjust)]
  | X.Andq (a1, a2) ->
    [ Andq
        ( offset (convert_arg a1) deref_adjust
        , offset (convert_arg a2) deref_adjust ) ]
  | X.Sarq (a1, a2) ->
    [ Sarq
        ( offset (convert_arg a1) deref_adjust
        , offset (convert_arg a2) deref_adjust ) ]
  | X.Callq (l, _) -> [Callq l]
  | X.Retq -> [Retq]
  | X.Jmp (Label l) -> [Jmp (Label (fix_label l))]
  | X.JmpIf (cc, Label l) -> [JmpIf (cc, Label (fix_label l))]
  | X.Leaq (a1, a2) ->
    [ Leaq
        ( offset (convert_arg a1) deref_adjust
        , offset (convert_arg a2) deref_adjust ) ]
  | X.TailJmp (a, _) ->
    conclusion_code conclusion_params
    @ [TailJmp (offset (convert_arg a) deref_adjust)]
  | X.IndirectCallq (a, _) ->
    [IndirectCallq (offset (convert_arg a) deref_adjust)]

let rec instrs_of_block (conclusion_params : RegSet.t * int * int)
  (b : X.instr list) deref_adjust : instr list =
  match b with
  | [] -> []
  | h :: t ->
    adjust_stack_access conclusion_params h deref_adjust
    @ instrs_of_block conclusion_params t deref_adjust

(* Convert a labeled block to a list of instructions. *)
let asm_of_lb (conclusion_params : RegSet.t * int * int) (deref_adjust : int)
  (lb : label * X.block) : instr list =
  let Label l, X.Block b = lb in
  Label (fix_label l) :: instrs_of_block conclusion_params b deref_adjust

let prelude_conclusion_def (def : X.def) : instr list =
  (* Unpack the definition. *)
  let (Def (lbl, finfo, fcont)) = def in
  let X.{body = lbs; _} = fcont in
  let (X.Finfo {num_spilled; num_spilled_root; used_callee}) = finfo in
  let num_callees = RegSet.cardinal used_callee in
  (* Amount to shift all stack locations that are relative to %rbp: *)
  let deref_adjust = 8 * num_callees in
  let extra_stack_space =
    align_16 (8 * (num_spilled + num_callees)) - (8 * num_callees)
  in
  let conclusion_params = (used_callee, extra_stack_space, num_spilled_root) in
  let ep = epilog lbl conclusion_params in
  let lbs' = List.concat_map (asm_of_lb conclusion_params deref_adjust) lbs in
  lbs' @ ep

let prelude_conclusion (prog : X.program) : program =
  let (X86Program defs) = prog in
  X86Program (List.concat_map prelude_conclusion_def defs)
