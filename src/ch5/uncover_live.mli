(** "Uncover live" pass. 
    Do liveness analysis on assembly language instructions. *)

(** Do the liveness analysis on a program. *)
val uncover_live :
  (X86_var_loop.info1, X86_var_loop.binfo1) X86_var_loop.program ->
  (X86_var_loop.info1, X86_var_loop.binfo2) X86_var_loop.program

