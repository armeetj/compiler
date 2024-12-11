(** "Build interference" pass.
    Build the variable/register location interference graph. *)

(** Build the interference graph for a program. *)
val build_interference :
  (X86_var_def.finfo1, X86_var_def.binfo2) X86_var_def.program ->
  (X86_var_def.finfo2, X86_var_def.binfo1) X86_var_def.program
