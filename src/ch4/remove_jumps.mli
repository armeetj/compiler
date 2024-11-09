(** "Remove jumps" pass. 
    Remove unnecessary jump instructions (coalesce blocks). *)

val remove_jumps :
  ('a, X86_var_if.binfo1) X86_var_if.program ->
  ('a, X86_var_if.binfo1) X86_var_if.program

