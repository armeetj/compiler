(** Definitional interpreter for the "Lfun" language. *)

open Types
open Interp

(* Reusable parts for later interpreters. *)

val void_exp : fexp
val bool_exp : bool -> fexp
val int_exp  : int -> fexp
val var_exp  : var -> fexp

val prim_exp     : core_op -> fexp list -> fexp
val set_bang_exp : var -> fexp -> fexp
val begin_exp    : fexp list -> fexp -> fexp
val if_exp       : fexp -> fexp -> fexp -> fexp
val and_exp      : fexp -> fexp -> fexp
val or_exp       : fexp -> fexp -> fexp
val while_exp    : fexp -> fexp -> fexp
val let_exp      : var -> fexp -> fexp -> fexp
val vec_exp      : fexp list -> 'a -> fexp  (* 2nd arg is ignored *)
val vec_len_exp  : fexp -> fexp
val vec_ref_exp  : fexp -> int -> fexp
val vec_set_exp  : fexp -> int -> fexp -> fexp
val apply_exp    : fexp -> fexp list -> fexp

val make_initial_env : (var * fun_value) list -> env_t

(** Interpreter. *)
val interp : Lfun.program -> int
