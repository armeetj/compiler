(** "Prelude and conclusion" pass. Add prelude and conclusion. *)

val resize_initial_heap_size : int -> unit
(** Resize the initial size of the heap used for memory allocation. *)

val prelude_conclusion : X86_def.program -> X86_asm.program
