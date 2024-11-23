open Sexplib.Std
open Types

(* ----------------------------------------------------------------------
 * Types.
 * ---------------------------------------------------------------------- *)

type arg = Imm of int | Reg of reg | Deref of reg * int | Var of var
[@@deriving sexp]

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

type 'a program = X86Program of 'a * (label * block) list [@@deriving sexp]

type info1 = Info1 of {locals_types : (var * ty) list} [@@deriving sexp]

type info2 = Info2 of {stack_space : int} [@@deriving sexp]
