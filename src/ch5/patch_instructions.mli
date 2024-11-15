(** "Patch instructions" pass. 
    Fix instructions that have two memory accesses. *)

val patch_instructions :
  (X86_var_loop.info3, X86_var_loop.binfo1) X86_var_loop.program
    -> X86_loop.program
