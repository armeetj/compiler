open Sexplib.Std
open Types
module X = X86_var

type arg = Imm of int | Reg of reg | Deref of reg * int [@@deriving sexp]

type instr =
  | Addq of arg * arg
  | Subq of arg * arg
  | Negq of arg
  | Movq of arg * arg
  | Pushq of arg
  | Popq of arg
  | Callq of label * int
  | Retq
  | Jmp of label
[@@deriving sexp]

type block = Block of instr list [@@deriving sexp]

type info =
  | Info of
      {locals_types : (var * ty) list; num_spilled : int; used_callee : RegSet.t}
[@@deriving sexp]

type program = X86Program of info * (label * block) list [@@deriving sexp]
