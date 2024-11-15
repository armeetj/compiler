(** Type checking the "Cloop" language. *)

open Cloop

(** Type checker. A `Type_error` exception is raised on a type error. *)
val type_check : program -> program
