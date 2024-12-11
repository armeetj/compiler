(** Peephole optimization pass. *)

(** The peephole optimizer. *)
val optimize : X86_asm.program -> X86_asm.program
