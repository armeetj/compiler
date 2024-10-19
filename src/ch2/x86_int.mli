(** x86_int assembly language *)

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
  | Callq of label * int
  | Retq
  | Jmp of label
[@@deriving sexp]

(** Blocks. *)
type block = Block of instr list [@@deriving sexp]

(** Info field: required stack space. *)
type info = Info of { stack_space : int } [@@deriving sexp]

(** Programs. *)
type program = X86Program of info * (label * block) list [@@deriving sexp]
