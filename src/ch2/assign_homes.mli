(** "Assign homes" pass. 
    Get rid of "var" forms in assembly listings. *)

val assign_homes :
  X86_var.info1 X86_var.program -> X86_var.info2 X86_var.program
