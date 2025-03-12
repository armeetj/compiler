(** Peephole optimization pass. *)

val optimize : X86_asm.program -> X86_asm.program
(** The peephole optimizer. *)
