(** "Patch instructions" pass. 
    Fix instructions that have two memory accesses. *)

val patch_instructions :
  (X86_var_if.info3, X86_var_if.binfo1) X86_var_if.program -> X86_if.program
