(** The "Cloop" intermediate language. *)

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
  | Atm  of atm
  | Prim of core_op * atm list
[@@deriving sexp]

(** Statements. *)
type stmt =
  | Assign of var * exp
  | PrimS  of stmt_op * atm list
[@@deriving sexp]

(** Statements in tail position. *)
type tail =
  | Return of exp
  | Seq    of stmt * tail
  | Goto   of label
  | IfStmt of {
      op        : cmp_op;
      arg1      : atm;
      arg2      : atm;
      jump_then : label;
      jump_else : label;
    }
[@@deriving sexp]

(** Program metadata. *)
type info = Info of { locals_types : (var * ty) list }
[@@deriving sexp]

(** Program type. *)
type program = CProgram of info * (label * tail) list
[@@deriving sexp]

(** Extract all the variables from a program.
    Make sure that there are no duplicates and that
    variables are extracted in order. *)
val get_vars : program -> var list

(** Get the jump labels from a tail. *)
val get_jump_labels : tail -> label list

