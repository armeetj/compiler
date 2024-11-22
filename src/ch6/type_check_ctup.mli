(** Type checking the "Ctup" language. *)

(** Type checker. A `Type_error` exception is raised on a type error. *)
val type_check : Ctup.program -> Ctup.program
