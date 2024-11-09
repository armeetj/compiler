(** "Select instructions" pass. 
    Select assembly language instructions (first pass). *)

val select_instructions :
  Cif.program -> (X86_var_if.info1, X86_var_if.binfo1) X86_var_if.program
