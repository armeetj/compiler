(** Type checking the "Lfun" language. *)

(** Type checker. A `Type_error` exception is raised on a type error. *)
val type_check : Lfun.program -> Lfun.program
