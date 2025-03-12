(** Type checking the "Cfun" language. *)

val type_check : Cfun.program -> Cfun.program
(** Type checker. A `Type_error` exception is raised on a type error. *)
