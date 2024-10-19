(** The "Lvar" language. *)

open Types

(** Expressions. *)
type exp =
  | Int of int
  | Var of var
  | Read (* read an integer from stdin *)
  | Negate of exp
  | Add of exp * exp
  | Sub of exp * exp
  | Let of var * exp * exp
[@@deriving sexp]

(** Programs. *)
type program = Program of exp [@@deriving sexp]
