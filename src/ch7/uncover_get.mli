(** "Uncover get" pass: rewrite accessors of mutable variables. *)

val uncover_get : Lfun_ref_alloc.program -> Lfun_ref_alloc_get.program
