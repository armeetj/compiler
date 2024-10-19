(** "Prelude and conclusion" pass.
    Add prelude and conclusion, and generate abstract x86 assembly code. *)

val prelude_conclusion : X86_int.program -> X86_asm.program
