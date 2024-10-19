(** The "Cvar" intermediate language. *)

open Types

(** Atomic expressions. *)
type atm = Int of int | Var of var [@@deriving sexp]

(** Expressions. *)
type exp =
  | Atm of atm
  | Read (* read an integer from stdin *)
  | Negate of atm
  | Add of atm * atm
  | Sub of atm * atm
[@@deriving sexp]

(** Statements. *)
type stmt = Assign of var * exp [@@deriving sexp]

(** Statements in tail position. *)
type tail = Return of exp | Seq of stmt * tail [@@deriving sexp]

(** Program metadata. *)
type info = Info of { locals_types : (var * ty) list } [@@deriving sexp]

(** Programs. *)
type program = CProgram of info * (label * tail) list [@@deriving sexp]

val add_type_info : program -> program
(** Add type information to a CVar program. *)
