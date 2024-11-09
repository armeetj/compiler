open Sexplib.Std
open Types

type atm =
  | Bool of bool
  | Int  of int
  | Var  of var
[@@deriving sexp]

type exp =
  | Atm  of atm
  | Prim of core_op * atm list
  | If   of exp * exp * exp
  | Let  of var * exp * exp
[@@deriving sexp]

type program = Program of exp
[@@deriving sexp]
