open Sexplib.Std
open Types

type arg =
  | Imm of int
  | Reg of reg
  | ByteReg of bytereg
  | Deref of reg * int
  | GlobalArg of label
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
  | Callq of label * int (* int = arity of the call *)
  | Retq
  | Jmp of label
  | JmpIf of cc * label
[@@deriving sexp]

type block = Block of instr list [@@deriving sexp]

type info =
  | Info of
      { locals_types : (var * ty) list
      ; num_spilled : int
      ; num_spilled_root : int
      ; used_callee : RegSet.t }
[@@deriving sexp]

type program = X86Program of info * (label * block) list [@@deriving sexp]
