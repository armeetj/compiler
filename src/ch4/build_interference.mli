(** "Build interference" pass.
    Build the variable/register location interference graph. *)

(** Build the interference graph for a program. *)
val build_interference :
  (X86_var_if.info1, X86_var_if.binfo2) X86_var_if.program ->
  (X86_var_if.info2, X86_var_if.binfo1) X86_var_if.program
