(** "Patch instructions" pass. 
    Fix instructions that have two memory accesses. *)

val patch_instructions :
  (X86_var_global.info3, X86_var_global.binfo1) X86_var_global.program ->
  X86_global.program
