(** "Select instructions" pass. 
    Select assembly language instructions (first pass). *)

val select_instructions :
  Ctup.program ->
    (X86_var_global.info1, X86_var_global.binfo1) X86_var_global.program
