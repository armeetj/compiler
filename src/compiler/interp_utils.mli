(** Utilities for definitional interpreters. *)

val init_gc_globals : unit -> unit
(** Initialize simulated GC global variables. *)

val free_ptr : int ref
(** Global variable: free pointer. *)

val fromspace_end : int ref
(** Global variable: end location of the "from space". *)

val collect : int -> unit
(** Run the simulated GC. *)

val allocate : int -> unit
(** Allocate N bytes in the simulated GC. *)
