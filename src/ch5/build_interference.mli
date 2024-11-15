(** "Build interference" pass.
    Build the variable/register location interference graph. *)

(** Build the interference graph for a program. *)
val build_interference :
  (X86_var_loop.info1, X86_var_loop.binfo2) X86_var_loop.program ->
  (X86_var_loop.info2, X86_var_loop.binfo1) X86_var_loop.program
