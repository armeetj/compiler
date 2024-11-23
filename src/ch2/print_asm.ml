open Support
open Utils
open Types
open X86_asm

let string_of_arg (a : arg) : string =
  match a with
  | Imm i ->
      "$" ^ string_of_int i
  | Reg r ->
      "%" ^ string_of_reg r
  | Deref (r, i) ->
      Printf.sprintf "%d(%%%s)" i (string_of_reg r)

let string_of_instr (i : instr) : string =
  let sp = Printf.sprintf in
  let soi = string_of_arg in
  let pad = "    " in
  match i with
  | Addq (a1, a2) ->
      pad ^ sp "addq %s, %s" (soi a1) (soi a2)
  | Subq (a1, a2) ->
      pad ^ sp "subq %s, %s" (soi a1) (soi a2)
  | Negq a ->
      pad ^ sp "negq %s" (soi a)
  | Movq (a1, a2) ->
      pad ^ sp "movq %s, %s" (soi a1) (soi a2)
  | Pushq a ->
      pad ^ sp "pushq %s" (soi a)
  | Popq a ->
      pad ^ sp "popq %s" (soi a)
  | Callq (Label lbl) ->
      pad ^ sp "callq %s" lbl
  | Retq ->
      pad ^ sp "retq"
  | Jmp (Label lbl) ->
      pad ^ sp "jmp %s" lbl
  | Label lbl ->
      "\n" ^ sp "%s:" lbl
  | Global (Label lbl) ->
      "\n" ^ pad ^ sp ".globl %s" lbl

let print_asm (prog : program) : string =
  let (X86Program instrs) = prog in
  let s = string_map ~sep:"\n" string_of_instr instrs in
  (* Strip leading newline, if any. *)
  let len = String.length s in
  (if len > 0 && s.[0] = '\n' then String.sub s 1 (len - 1) else s) ^ "\n"
