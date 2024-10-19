(** x86_var pseudo-assembly language. *)

open Types

(** Arguments. *)
type arg = Imm of int | Reg of reg | Deref of reg * int | Var of var
[@@deriving sexp]

(** Instructions. *)
type instr =
  | Addq of arg * arg
  | Subq of arg * arg
  | Negq of arg
  | Movq of arg * arg
  | Pushq of arg
  | Popq of arg
  | Callq of label * int (* int = arity of the call *)
  | Retq
  | Jmp of label
[@@deriving sexp]

(** Blocks. *)
type block = Block of instr list [@@deriving sexp]

(** A program type parameterized over program info. *)
type 'a program = X86Program of 'a * (label * block) list [@@deriving sexp]

(** First program info type: a variable->type map. *)
type info1 = Info1 of { locals_types : (var * ty) list } [@@deriving sexp]

(** Second program info type: an integer stack space requirement. *)
type info2 = Info2 of { stack_space : int } [@@deriving sexp]
