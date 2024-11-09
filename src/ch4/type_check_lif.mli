(** Type checking the "Lif" language. *)

(** Type checker. A `Type_error` exception is raised on a type error. *)
val type_check : Lif.program -> Lif.program
