(** "Remove complex operands" pass: replace complex operands with
    simple ones. *)

val remove_complex_operands : Lfun_ref_alloc_get.program -> Lfun_ref_mon.program
