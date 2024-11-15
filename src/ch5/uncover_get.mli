(** "Uncover get" pass: rewrite accessors of mutable variables. *)

val uncover_get : Lwhile_shrink.program -> Lwhile_get.program
