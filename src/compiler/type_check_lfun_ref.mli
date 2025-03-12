(** Type checking the "Lfun_ref" language. *)

val type_check : Lfun_ref.program -> Lfun_ref.program
(** Type checker. A `Type_error` exception is raised on a type error. *)
