(** The "Lfun_ref" language. *)

open Types

(** Expressions. *)
type exp =
  | Void
  | Bool of bool
  | Int of int
  | Var of var
  | FunRef of label * int (* new: function name + arity *)
  | Prim of core_op * exp list
  | SetBang of var * exp
  | Begin of exp list * exp
  | If of exp * exp * exp
  | While of exp * exp
  | Let of var * exp * exp
  | Vec of exp list * ty option
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

val convert_exp : (exp -> exp) -> exp -> exp
(** Convert an expression by applying a function to each subexpression. *)
