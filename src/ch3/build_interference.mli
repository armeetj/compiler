(** "Build interference" pass.
    Build the variable/register location interference graph. *)

(** Build the interference graph for a program. *)
val build_interference :
  (X86_var.info1, X86_var.binfo2) X86_var.program ->
  (X86_var.info2, X86_var.binfo1) X86_var.program
