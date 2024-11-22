(** "Uncover get" pass: rewrite accessors of mutable variables. *)

val uncover_get : Lalloc.program -> Lalloc_get.program
