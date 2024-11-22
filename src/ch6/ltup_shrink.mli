(** The "Ltup_shrink" language. *)

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
  | Vec     of exp list * ty    (* vector values, type info *)
  | VecLen  of exp              (* vector *)
  | VecRef  of exp * int        (* vector, index *)
  | VecSet  of exp * int * exp  (* vector, index, value *)
[@@deriving sexp]

(** Program type. *)
type program = Program of exp
[@@deriving sexp]

