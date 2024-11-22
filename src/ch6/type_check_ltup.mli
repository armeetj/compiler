(** Type checking the "Ltup" language. *)

(** Type checker. A `Type_error` exception is raised on a type error. *)
val type_check : Ltup.program -> Ltup.program
