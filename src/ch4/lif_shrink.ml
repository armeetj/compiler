open Sexplib.Std
open Types

type exp =
  | Bool of bool
  | Int of int
  | Var of var
  | Prim of core_op * exp list
  | If of exp * exp * exp
  | Let of var * exp * exp
[@@deriving sexp]

type program = Program of exp [@@deriving sexp]
