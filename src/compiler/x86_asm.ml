open Sexplib.Std
open Types

type arg =
  | Imm of int
  | Reg of reg
  | ByteReg of bytereg
  | Deref of reg * int
  | GlobalArg of reg * label
[@@deriving sexp]

type instr =
  | Addq of arg * arg
  | Subq of arg * arg
  | Negq of arg
  | Xorq of arg * arg
  | Cmpq of arg * arg
  | Andq of arg * arg
  | Sarq of arg * arg
  | Set of cc * arg
  | Movq of arg * arg
  | Movzbq of arg * arg
  | Pushq of arg
  | Popq of arg
  | Leaq of arg * arg
  | Callq of label
  | IndirectCallq of arg
  | Retq
  | Jmp of label
  | JmpIf of cc * label
  | TailJmp of arg
  | Label of string
  | Global of label
  | Align of int
[@@deriving sexp]

type program = X86Program of instr list [@@deriving sexp]
