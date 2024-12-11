open Sexplib.Std
open Types

type exp =
  | Void
  | Bool      of bool
  | Int       of int
  | Var       of var
  | FunRef    of label * int
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
  | Apply     of exp * exp list
[@@deriving sexp]

type def = Def of label * fun_contents
[@@deriving sexp]

and fun_contents =
  {
    args : (var * ty) list;
    ret  : ty;
    body : exp;
  }
[@@deriving sexp]

type program = Program of def list
[@@deriving sexp]

