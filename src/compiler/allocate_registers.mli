(** "Allocate registers" pass. *)

val set_register_color_list : Types.reg list -> unit
(** Set the registers to be used for register allocation. *)

val allocate_registers :
     (X86_var_def.finfo2, X86_var_def.binfo1) X86_var_def.program
  -> (X86_var_def.finfo3, X86_var_def.binfo1) X86_var_def.program
(** Allocate registers using a graph coloring algorithm. *)
