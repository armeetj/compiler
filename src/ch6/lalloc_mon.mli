(* The "Lalloc_mon" intermediate language. *)

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
  | Atm       of atm
  | Prim      of core_op * atm list
  | SetBang   of var * exp
  | Begin     of exp list * exp
  | If        of exp * exp * exp
  | While     of exp * exp
  | Let       of var * exp * exp
  | Collect   of int
  | Allocate  of int * ty
  | GlobalVal of var
  | VecLen    of atm
  | VecRef    of atm * int
  | VecSet    of atm * int * atm
[@@deriving sexp]

(** Program type. *)
type program = Program of exp
[@@deriving sexp]

