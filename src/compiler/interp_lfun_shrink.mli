(** Definitional interpreter for the "Lfun_shrink" language. *)

val run_main_function : Interp.env_t -> int
(** Run the "main" function, given the environment. *)

val interp : Lfun_shrink.program -> int
(** Interpreter. *)
