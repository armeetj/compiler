(** "Select instructions" pass. 
    Select assembly language instructions (first pass). *)

val select_instructions :
  Cfun.program ->
    (X86_var_def.finfo1, X86_var_def.binfo1) X86_var_def.program
