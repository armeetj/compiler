(** "Remove complex operands" pass: replace complex operands with
    simple ones. *)

val remove_complex_operands : Lalloc_get.program -> Lalloc_mon.program
