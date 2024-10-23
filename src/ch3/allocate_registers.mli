(** "Allocate registers" pass. *)

(** Set the registers to be used for register allocation. *)
val set_register_color_list : Types.reg list -> unit

(** Allocate registers using a graph coloring algorithm. *)
val allocate_registers :
  (X86_var.info2, X86_var.binfo1) X86_var.program ->
  (X86_var.info3, X86_var.binfo1) X86_var.program
