(** Definitional interpreter for the "Lif" language. *)

open Types
open Interp

(* Reusable parts for later interpreters. *)

val bool_exp : bool -> fexp
val int_exp  : int -> fexp
val var_exp  : var -> fexp
val prim_exp : core_op -> fexp list -> fexp
val if_exp   : fexp -> fexp -> fexp -> fexp
val and_exp  : fexp -> fexp -> fexp
val or_exp   : fexp -> fexp -> fexp
val let_exp  : var -> fexp -> fexp -> fexp

(** Interpreter. *)
val interp : Lif.program -> int

