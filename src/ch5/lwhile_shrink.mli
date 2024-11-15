(** The "Lwhile_shrink" language. *)

open Types

(** Expressions. *)
type exp =
  | Void
  | Bool    of bool
  | Int     of int
  | Var     of var
  | Prim    of core_op * exp list
  | SetBang of var * exp
  | Begin   of exp list * exp
  | If      of exp * exp * exp
  | While   of exp * exp
  | Let     of var * exp * exp
[@@deriving sexp]

(** Program type. *)
type program = Program of exp
[@@deriving sexp]

