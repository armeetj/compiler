(** "Remove unused blocks" pass. 
    Remove blocks that are never reached. *)

val remove_unused_blocks : Ctup.program -> Ctup.program
