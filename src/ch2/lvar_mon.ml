open Sexplib.Std
open Types

type atm = Int of int | Var of var [@@deriving sexp]

type exp =
  | Atm of atm
  | Read
  | Negate of atm
  | Add of atm * atm
  | Sub of atm * atm
  | Let of var * exp * exp
[@@deriving sexp]

type program = Program of exp [@@deriving sexp]
