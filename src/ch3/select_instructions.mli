(** "Select instructions" pass. 
    Select assembly language instructions (first pass). *)

val select_instructions :
  Cvar.program -> (X86_var.info1, X86_var.binfo1) X86_var.program
