(** Type checking the "Lfun" language. *)

val type_check : Lfun.program -> Lfun.program
(** Type checker. A `Type_error` exception is raised on a type error. *)
