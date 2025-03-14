open Support.Utils

(* Debug flag for garbage collector. *)
let debug_gc_eval = ref false

(*
 * The simulated garbage collector.
 *)

let free_ptr = ref 0

let fromspace_end = ref 0

(* Initialize the garbage collection global variables. *)
let init_gc_globals () =
  free_ptr := 0 ;
  fromspace_end := 0

(* Do one (simulated) garbage collection pass.
   "Allocate" twice as much memory as requested,
   so that not all memory requests result in garbage collection. *)
let collect n =
  if !debug_gc_eval then
    Printf.printf "Running garbage collector to get %d bytes." n ;
  free_ptr := 0 ;
  fromspace_end := 2 * n

(* Allocate `n` bytes. *)
let allocate n =
  if !debug_gc_eval then Printf.printf "Allocating %d bytes." n ;
  free_ptr := !free_ptr + n ;
  if !free_ptr >= !fromspace_end then
    failwithf "allocate: couldn't allocate %d bytes" n
