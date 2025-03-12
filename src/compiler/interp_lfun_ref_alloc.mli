(** Definitional interpreter for the "Lfun_ref_alloc" language. *)

open Types
open Interp

(* Reusable parts for later interpreters. *)

val collect_exp : int -> fexp

val allocate_exp : int -> ty -> fexp

val global_var_exp : var -> fexp

val default_val : ty -> value
(** Generate an "uninitialized" default value for any type.
    The actual value doesn't matter. *)

val interp : Lfun_ref_alloc.program -> int
(** Interpreter. *)
