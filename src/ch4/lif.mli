(** The "Lif" language. *)

open Types

(** Expressions. *)
type exp =
  | Bool of bool
  | Int  of int
  | Var  of var
  | Prim of core_op * exp list
  | If   of exp * exp * exp
  | And  of exp * exp
  | Or   of exp * exp
  | Let  of var * exp * exp
[@@deriving sexp]

(** Program type. *)
type program = Program of exp
[@@deriving sexp]
