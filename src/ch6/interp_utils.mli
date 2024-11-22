(** Utilities for definitional interpreters. *)

(** Initialize simulated GC global variables. *)
val init_gc_globals : unit -> unit

(** Global variable: free pointer. *)
val free_ptr : int ref

(** Global variable: end location of the "from space". *)
val fromspace_end : int ref

(** Run the simulated GC. *)
val collect : int -> unit

(** Allocate N bytes in the simulated GC. *)
val allocate : int -> unit

(** Generate a default value for a type. *)
val default_val : Types.ty -> Interp.value

