(** "Uncover live" pass. 
    Do liveness analysis on assembly language instructions. *)

(** Do the liveness analysis on a program. *)
val uncover_live :
  (X86_var_if.info1, X86_var_if.binfo1) X86_var_if.program ->
  (X86_var_if.info1, X86_var_if.binfo2) X86_var_if.program

