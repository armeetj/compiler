(* The "Lwhile_mon" intermediate language. *)

open Types

(** Atomic expressions. *)
type atm =
  | Void
  | Bool of bool
  | Int  of int
  | Var  of var
[@@deriving sexp]

(** Expressions. *)
type exp =
  | Atm     of atm
  | Prim    of core_op * atm list
  | SetBang of var * exp
  | Begin   of exp list * exp
  | If      of exp * exp * exp
  | While   of exp * exp
  | Let     of var * exp * exp
[@@deriving sexp]

(** Program type. *)
type program = Program of exp
[@@deriving sexp]
