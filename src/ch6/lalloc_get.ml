open Sexplib.Std
open Types

type exp =
  | Void
  | Bool      of bool
  | Int       of int
  | Var       of var
  | Prim      of core_op * exp list
  | SetBang   of var * exp
  | GetBang   of var
  | Begin     of exp list * exp
  | If        of exp * exp * exp
  | While     of exp * exp
  | Let       of var * exp * exp
  | Collect   of int
  | Allocate  of int * ty
  | GlobalVal of var
  | VecLen    of exp
  | VecRef    of exp * int
  | VecSet    of exp * int * exp
[@@deriving sexp]

type program = Program of exp
[@@deriving sexp]

