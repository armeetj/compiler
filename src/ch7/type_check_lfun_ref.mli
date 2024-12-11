(** Type checking the "Lfun_ref" language. *)

(** Type checker. A `Type_error` exception is raised on a type error. *)
val type_check : Lfun_ref.program -> Lfun_ref.program
