(** The "Lfun_ref_alloc" language. *)

open Types

(** Expressions. *)
type exp =
  | Void
  | Bool of bool
  | Int of int
  | Var of var
  | FunRef of label * int
  | Prim of core_op * exp list
  | SetBang of var * exp
  | Begin of exp list * exp
  | If of exp * exp * exp
  | While of exp * exp
  | Let of var * exp * exp
  | Collect of int (* run garbage collector *)
  | Allocate of int * ty (* allocate memory *)
  | GlobalVal of var (* read global variable *)
  | VecLen of exp
  | VecRef of exp * int
  | VecSet of exp * int * exp
  | Apply of exp * exp list
[@@deriving sexp]

(** Functions. *)
type fun_contents =
  {args : (var * ty) list; ret : ty (* return type *); body : exp}
[@@deriving sexp]

(** Definitions. *)
type def = Def of label * fun_contents [@@deriving sexp]

(** Program type. *)
type program = Program of def list [@@deriving sexp]
