(** Definitional interpreter for the "Lalloc" language. *)

open Types
open Interp

(* Reusable parts for later interpreters. *)

val collect_exp    : int -> fexp
val allocate_exp   : int -> ty -> fexp
val global_var_exp : var -> fexp

(** Generate an "uninitialized" default value for any type.
    The actual value doesn't matter. *)
val default_val : ty -> value

(* Interpreter. *)
val interp : Lalloc.program -> int

