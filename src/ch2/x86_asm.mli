(** Abstract x86 assembly language. *)

open Types

(** Arguments. *)
type arg = Imm of int | Reg of reg | Deref of reg * int [@@deriving sexp]

(** Instructions. *)
type instr =
  | Addq of arg * arg
  | Subq of arg * arg
  | Negq of arg
  | Movq of arg * arg
  | Pushq of arg
  | Popq of arg
  | Callq of label
  | Retq
  | Jmp of label
  | Label of string
  | Global of label
[@@deriving sexp]

(** An x86 program. *)
type program = X86Program of instr list [@@deriving sexp]
