(** "Uncover live" pass. 
    Do liveness analysis on assembly language instructions. *)

(** Do the liveness analysis on a program. *)
val uncover_live :
  (X86_var.info1, X86_var.binfo1) X86_var.program ->
  (X86_var.info1, X86_var.binfo2) X86_var.program

