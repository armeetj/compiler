(** "Uncover live" pass. 
    Do liveness analysis on assembly language instructions. *)

(** Do the liveness analysis on a program. *)
val uncover_live :
  (X86_var_def.finfo1, X86_var_def.binfo1) X86_var_def.program ->
  (X86_var_def.finfo1, X86_var_def.binfo2) X86_var_def.program

