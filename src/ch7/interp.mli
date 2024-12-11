(** General interpreter types and functions. *)

open Types

(** Simple value types that operators can work on directly. *)
type simple_value = [
  | `VoidV
  | `BoolV of bool
  | `IntV  of int
]

(** Values. *)
type value = [
  | simple_value
  | `VecV of value array
  | `FunV of fun_value * env_t option ref
]

(** Environments. *)
and env_t = value ref Env.t

(** "Functional expressions" are represented as
    functions from environments to values. *)
and fexp = env_t -> value

(** Function values. *)
and fun_value =
  {
    vargs : (var * ty) list;
    vret  : ty;               (* return type *)
    vbody : fexp;
  }

(** Interpret a comparison operator on simple values. *)
val interp_cmp_op_simple : cmp_op -> [> simple_value] list -> simple_value

(** Interpret a statement operator on simple values. *)
val interp_stmt_op_simple : stmt_op -> [> simple_value] list -> simple_value

(** Interpret a core operator on simple values. *)
val interp_core_op_simple : core_op -> [> simple_value] list -> simple_value

(** Convert a value to a string. *)
val string_of_value :
  ([< simple_value | `VecV of 'a array | `FunV of 'b ] as 'a) -> string

(** Convert a value (extended from `simple_value`) to an int,
    or signal an error with a given error message. *)
val expect_int : err_msg:string ->
      to_string:(([> `IntV of int] as 'a) -> string) -> 'a -> int
