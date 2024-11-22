(** "Prelude and conclusion" pass. Add prelude and conclusion. *)

(** Resize the initial size of the heap used for memory allocation. *)
val resize_initial_heap_size : int -> unit

val prelude_conclusion : X86_global.program -> X86_asm.program
