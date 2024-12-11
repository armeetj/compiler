(** Definitional interpreter for the "Lfun_shrink" language. *)

(** Run the "main" function, given the environment. *)
val run_main_function : Interp.env_t -> int

(** Interpreter. *)
val interp : Lfun_shrink.program -> int
