open Support
open Utils
open Types
open X86_asm

let string_of_arg (a : arg) : string =
  match a with
    | Imm       i        -> "$" ^ string_of_int i
    | Reg       r        -> "%" ^ string_of_reg r
    | ByteReg   r        -> "%" ^ string_of_bytereg r
    | Deref     (r, i)   -> Printf.sprintf "%d(%%%s)" i (string_of_reg r)
    | GlobalArg (r, lbl) ->
        Printf.sprintf "%s(%%%s)"
          (string_of_label lbl)
          (string_of_reg r)

let string_of_cc (c : cc) : string =
  match c with
    | CC_e  -> "e"
    | CC_l  -> "l"
    | CC_le -> "le"
    | CC_g  -> "g"
    | CC_ge -> "ge"

let string_of_instr (i : instr) : string =
  let sp = Printf.sprintf in
  let soa = string_of_arg in
  let c2s = string_of_cc in
  let pad = "    " in
    match i with
      | Addq (a1, a2) ->
          pad ^ sp "addq %s, %s" (soa a1) (soa a2)
      | Subq (a1, a2) ->
          pad ^ sp "subq %s, %s" (soa a1) (soa a2)
      | Negq a -> 
          pad ^ sp "negq %s" (soa a)
      | Xorq (a1, a2) ->
          pad ^ sp "xorq %s, %s" (soa a1) (soa a2)
      | Cmpq (a1, a2) ->
          pad ^ sp "cmpq %s, %s" (soa a1) (soa a2)
      | Andq (a1, a2) ->
          pad ^ sp "andq %s, %s" (soa a1) (soa a2)
      | Sarq (a1, a2) ->
          pad ^ sp "sarq %s, %s" (soa a1) (soa a2)
      | Set (cc, a) ->
          pad ^ sp "set%s %s" (c2s cc) (soa a)
      | Movq (a1, a2) ->
          pad ^ sp "movq %s, %s" (soa a1) (soa a2)
      | Movzbq (a1, a2) -> 
          pad ^ sp "movzbq %s, %s" (soa a1) (soa a2)
      | Pushq a ->
          pad ^ sp "pushq %s" (soa a)
      | Popq a -> 
          pad ^ sp "popq %s" (soa a)
      | Leaq (a1, a2) ->
          pad ^ sp "leaq %s, %s" (soa a1) (soa a2)
      | Callq (Label lbl) ->
          pad ^ sp "callq %s" lbl
      | IndirectCallq a ->
          pad ^ sp "callq *%s" (soa a)
      | Retq ->
          pad ^ sp "retq"
      | Jmp (Label lbl) ->
          pad ^ sp "jmp %s" lbl
      | JmpIf (cc, Label lbl) ->
          pad ^ sp "j%s %s" (c2s cc) lbl
      | TailJmp a ->
          pad ^ sp "jmp *%s" (soa a)
      | Label lbl ->
          "\n" ^ sp "%s:" lbl
      | Global (Label lbl) ->
          "\n" ^ pad ^ sp ".globl %s" lbl
      | Align i ->
          pad ^ sp ".align %d" i

let print_asm (prog : program) : string =
  let (X86Program instrs) = prog in
  let s = string_map ~sep:"\n" string_of_instr instrs in
    (* Strip leading newline, if any. *)
    let len = String.length s in
      (if (len > 0) && (s.[0] = '\n') then
          String.sub s 1 (len - 1)
       else s) ^ "\n"
