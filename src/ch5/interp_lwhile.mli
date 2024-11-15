(** Definitional interpreter for the "Lwhile" language. *)

open Types
open Interp

(* Reusable parts for later interpreters. *)

val void_exp     : fexp
val bool_exp     : bool -> fexp
val int_exp      : int -> fexp
val var_exp      : var -> fexp
val prim_exp     : core_op -> fexp list -> fexp
val set_bang_exp : var -> fexp -> fexp
val begin_exp    : fexp list -> fexp -> fexp
val if_exp       : fexp -> fexp -> fexp -> fexp
val and_exp      : fexp -> fexp -> fexp
val or_exp       : fexp -> fexp -> fexp
val while_exp    : fexp -> fexp -> fexp
val let_exp      : var -> fexp -> fexp -> fexp

(** Interpreter. *)
val interp : Lwhile.program -> int

