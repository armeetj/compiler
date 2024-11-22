(** "Uncover live" pass. 
    Do liveness analysis on assembly language instructions. *)

(** Do the liveness analysis on a program. *)
val uncover_live :
  (X86_var_global.info1, X86_var_global.binfo1) X86_var_global.program ->
  (X86_var_global.info1, X86_var_global.binfo2) X86_var_global.program

