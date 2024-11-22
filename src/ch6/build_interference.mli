(** "Build interference" pass.
    Build the variable/register location interference graph. *)

(** Build the interference graph for a program. *)
val build_interference :
  (X86_var_global.info1, X86_var_global.binfo2) X86_var_global.program ->
  (X86_var_global.info2, X86_var_global.binfo1) X86_var_global.program
