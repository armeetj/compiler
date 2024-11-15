(** "Remove jumps" pass. 
    Remove unnecessary jump instructions (coalesce blocks). *)

val remove_jumps :
  ('a, X86_var_loop.binfo1) X86_var_loop.program ->
  ('a, X86_var_loop.binfo1) X86_var_loop.program

