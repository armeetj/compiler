(** "Patch instructions" pass. 
    Fix instructions that have two memory accesses. *)

val patch_instructions : X86_var.info2 X86_var.program -> X86_int.program
