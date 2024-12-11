(** The "Cfun" intermediate language. *)

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
  | Allocate  of int * ty
  | GlobalVal of var
  | VecLen    of atm
  | VecRef    of atm * int
  | VecSet    of atm * int * atm
  | FunRef    of label * int
  | Call      of atm * atm list
[@@deriving sexp]

(** Statements. *)
type stmt =
  | Assign  of var * exp
  | PrimS   of stmt_op * atm list
  | CallS   of atm * atm list
  | Collect of int
  | VecSetS of atm * int * atm
[@@deriving sexp]

(** Statements in tail position. *)
type tail =
  | Return   of exp
  | TailCall of atm * atm list
  | Seq      of stmt * tail
  | Goto     of label
  | IfStmt   of {
      op        : cmp_op;
      arg1      : atm;
      arg2      : atm;
      jump_then : label;
      jump_else : label;
    }
[@@deriving sexp]

(** Functions. *)
type fun_contents =
  {
    args   : (var * ty) list;
    ret    : ty;
    locals : (var * ty) list;
    body   : (label * tail) list;
  }
[@@deriving sexp]

(** Definitions. *)
type def =
  | Def of label * fun_contents
[@@deriving sexp]

(** The type of programs. *)
type program = CProgram of def list
[@@deriving sexp]

(** Extract all the variables from a (label, tail) list.
    Make sure that there are no duplicates and that
    variables are extracted in order. *)
val get_vars : (label * tail) list -> var list

(** Get the jump labels from a tail. *)
val get_jump_labels : tail -> label list

