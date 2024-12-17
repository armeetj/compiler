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

let epilog (callee_saves : RegSet.t) (ss : int) (rs : int) : instr list =
  let main = fix_label "main" in
  [ Global (Types.Label main)
  ; Label main
  ; Pushq (Reg Rbp)
  ; Movq (Reg Rsp, Reg Rbp) ]
  @ List.map (fun reg -> Pushq (Reg reg)) (RegSet.elements callee_saves)
  @ [ Subq (Imm ss, Reg Rsp)
    ; Movq (Imm !init_heap_size, Reg Rdi)
    ; Movq (Imm !init_heap_size, Reg Rsi)
    ; Callq (Label (fix_label "initialize"))
    ; Movq (GlobalArg (Rip, Label (fix_label "rootstack_begin")), Reg R15) ]
  @ List.init rs (fun i -> Movq (Imm 0, Deref (R15, i * 8)))
  @ [ Addq (Imm (rs * 8), Reg R15)
    ; Jmp (Label (fix_label "start"))
    ; Label (fix_label "conclusion")
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

let adjust_stack_access instr deref_adjust =
  match instr with
  | X.Addq (a1, a2) ->
    Addq
      ( offset (convert_arg a1) deref_adjust
      , offset (convert_arg a2) deref_adjust )
  | X.Subq (a1, a2) ->
    Subq
      ( offset (convert_arg a1) deref_adjust
      , offset (convert_arg a2) deref_adjust )
  | X.Negq a -> Negq (offset (convert_arg a) deref_adjust)
  | X.Xorq (a1, a2) ->
    Xorq
      ( offset (convert_arg a1) deref_adjust
      , offset (convert_arg a2) deref_adjust )
  | X.Cmpq (a1, a2) ->
    Cmpq
      ( offset (convert_arg a1) deref_adjust
      , offset (convert_arg a2) deref_adjust )
  | X.Set (cc, a) -> Set (cc, offset (convert_arg a) deref_adjust)
  | X.Movq (a1, a2) ->
    Movq
      ( offset (convert_arg a1) deref_adjust
      , offset (convert_arg a2) deref_adjust )
  | X.Movzbq (a1, a2) ->
    Movzbq
      ( offset (convert_arg a1) deref_adjust
      , offset (convert_arg a2) deref_adjust )
  | X.Pushq a -> Pushq (offset (convert_arg a) deref_adjust)
  | X.Popq a -> Popq (offset (convert_arg a) deref_adjust)
  | X.Andq (a1, a2) ->
    Andq
      ( offset (convert_arg a1) deref_adjust
      , offset (convert_arg a2) deref_adjust )
  | X.Sarq (a1, a2) ->
    Sarq
      ( offset (convert_arg a1) deref_adjust
      , offset (convert_arg a2) deref_adjust )
  | X.Callq (l, _) -> Callq l
  | X.Retq -> Retq
  | X.Jmp (Label l) -> Jmp (Label (fix_label l))
  | X.JmpIf (cc, Label l) -> JmpIf (cc, Label (fix_label l))

let instrs_of_block (b : X.instr list) deref_adjust : instr list =
  List.map (fun h -> adjust_stack_access h deref_adjust) b

(* Convert a labeled block to a list of instructions. *)
let asm_of_lb (deref_adjust : int) (lb : label * X.block) : instr list =
  let Label l, X.Block b = lb in
  Label (fix_label l) :: instrs_of_block b deref_adjust

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
