(** The "Lalloc" language. *)

open Types

(** Expressions. *)
type exp =
  | Void
  | Bool      of bool
  | Int       of int
  | Var       of var
  | Prim      of core_op * exp list
  | SetBang   of var * exp
  | Begin     of exp list * exp
  | If        of exp * exp * exp
  | While     of exp * exp
  | Let       of var * exp * exp
  | Collect   of int              (* run garbage collector *)
  | Allocate  of int * ty         (* allocate memory *)
  | GlobalVal of var              (* read global variable *)
  | VecLen    of exp              (* vector *)
  | VecRef    of exp * int        (* vector, index *)
  | VecSet    of exp * int * exp  (* vector, index, value *)
[@@deriving sexp]

(** Program type. *)
type program = Program of exp
[@@deriving sexp]

