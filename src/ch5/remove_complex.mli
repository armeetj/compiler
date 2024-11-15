(** "Remove complex operands" pass: replace complex operands with
    simple ones. *)

val remove_complex_operands : Lwhile_get.program -> Lwhile_mon.program
