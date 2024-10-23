(** "Patch instructions" pass.
    Fix instructions that have two memory accesses. *)

val patch_instructions :
  (X86_var.info3, X86_var.binfo1) X86_var.program -> X86_int.program
