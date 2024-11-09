(* The "Lif_mon" intermediate language. *)

open Types

(** Atomic expressions. *)
type atm =
  | Bool of bool
  | Int  of int
  | Var  of var
[@@deriving sexp]

(** Expressions. *)
type exp =
  | Atm  of atm
  | Prim of core_op * atm list
  | If   of exp * exp * exp
  | Let  of var * exp * exp
[@@deriving sexp]

(** Program type. *)
type program = Program of exp
[@@deriving sexp]
