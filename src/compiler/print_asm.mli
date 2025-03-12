(** "Print assembly" pass.
    Convert abstract assembly language to a string. *)

val print_asm : X86_asm.program -> string
