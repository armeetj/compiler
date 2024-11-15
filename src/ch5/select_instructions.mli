(** "Select instructions" pass. 
    Select assembly language instructions (first pass). *)

val select_instructions :
  Cloop.program ->
    (X86_var_loop.info1, X86_var_loop.binfo1) X86_var_loop.program
