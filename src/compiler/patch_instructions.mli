(** "Patch instructions" pass. 
    Fix instructions that have two memory accesses. *)

val patch_instructions :
     (X86_var_def.finfo3, X86_var_def.binfo1) X86_var_def.program
  -> X86_def.program
