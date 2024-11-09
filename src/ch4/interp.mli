(** General interpreter types and functions. *)

open Types

(** Values. *)
type value =
  | BoolV of bool
  | IntV  of int
[@@deriving sexp]

(** Environments. *)
type env_t = value ref Env.t

(** "Functional expressions" are represented as
    functions from environments to values. *)
type fexp = env_t -> value

(** Interpret a comparison operator. *)
val interp_cmp_op : cmp_op -> value list -> value

(** Interpret a core operator. *)
val interp_core_op : core_op -> value list -> value

(** Convert a value to a string. *)
val string_of_value : value -> string

(** Convert a value to an int,
    or signal an error with a given error message. *)
val expect_int : err_msg:string -> value -> int
