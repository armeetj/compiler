(** Type checking the "Cfun" language. *)

(** Type checker. A `Type_error` exception is raised on a type error. *)
val type_check : Cfun.program -> Cfun.program
