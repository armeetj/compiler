(** Type checking the "Lwhile" language. *)

(** Type checker. A `Type_error` exception is raised on a type error. *)
val type_check : Lwhile.program -> Lwhile.program
