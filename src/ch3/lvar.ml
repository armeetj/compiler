open Sexplib.Std
open Types

type exp =
  | Int of int
  | Var of var
  | Read
  | Negate of exp
  | Add of exp * exp
  | Sub of exp * exp
  | Let of var * exp * exp
[@@deriving sexp]

type program = Program of exp
[@@deriving sexp]

