(** The "Lvar_mon" intermediate language. *)

open Types

(** Atomic expressions. *)
type atm =
  | Int of int
  | Var of var
[@@deriving sexp]

(** Expressions. *)
type exp =
  | Atm    of atm
  | Read
  | Negate of atm
  | Add    of atm * atm
  | Sub    of atm * atm
  | Let    of var * exp * exp
[@@deriving sexp]

(** Programs. *)
type program = Program of exp
[@@deriving sexp]
