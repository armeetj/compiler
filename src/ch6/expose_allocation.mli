(** "Expose allocation" pass: make vector allocation explicit. *)

val expose_allocation : Ltup_shrink.program -> Lalloc.program
