(** Type checking the "Cif" language. *)

open Cif

(** Type checker. A `Type_error` exception is raised on a type error.
    Type information is collected in the internal `info` field. *)
val type_check : program -> program
