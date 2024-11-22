(** "Remove jumps" pass. 
    Remove unnecessary jump instructions (coalesce blocks). *)

val remove_jumps :
  ('a, X86_var_global.binfo1) X86_var_global.program ->
  ('a, X86_var_global.binfo1) X86_var_global.program

