(** Types, exceptions, and functions for type checking. *)
open Types

(** Type errors. *)
exception Type_error of string

(** Type environments. *)
type ty_env_t = ty Types.Env.t

(** Convert a type to a string. *)
val string_of_ty : ty -> string

(** Convert a list of types to a string. *)
val string_of_ty_list : ty list -> string

(** Empty type environment. *)
val empty_ty_env : ty Types.Env.t

(** Compare two types for equality. *)
val ty_equal : ty -> ty -> bool

(** Compare two type lists for equality. *)
val ty_lists_equal : ty list -> ty list -> bool

(** Raise a type error, given an error message. *)
val ty_err_simple : string -> 'a

(** Raise a type error, given an error message
    and the expected and actual types. *)
val ty_err : string -> expected:ty -> got:ty -> 'a

(** Raise a type error, given an error message
    and expected and actual type lists. *)
val ty_list_err : string -> expected:ty list -> got:ty list -> 'a

(** Type check an operator application. *)
val type_check_op : [< Types.core_op] -> ty list -> ty

(** Get the obligatory return type of an operator. *)
val type_check_op_ret : [< Types.core_op] -> ty
