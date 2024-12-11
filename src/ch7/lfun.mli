(** The "Lfun" language. *)

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
  | And     of exp * exp
  | Or      of exp * exp
  | While   of exp * exp
  | Let     of var * exp * exp
  | Vec     of exp list * ty option  (* vector values, optional type info *)
  | VecLen  of exp                   (* vector *)
  | VecRef  of exp * int             (* vector, index *)
  | VecSet  of exp * int * exp       (* vector, index, value *)
  | Apply   of exp * exp list
[@@deriving sexp]

(** Functions. *)
type fun_contents =
  {
    args : (var * ty) list;
    ret  : ty;               (* return type *)
    body : exp;
  }
[@@deriving sexp]

(** Definitions. *)
type def = Def of var * fun_contents
[@@deriving sexp]

(** Program type. *)
type program = Program of def list * exp
[@@deriving sexp]

