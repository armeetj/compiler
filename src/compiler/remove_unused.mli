(** "Remove unused blocks" pass. 
    Remove blocks that are never reached. *)

val remove_unused_blocks : Cfun.program -> Cfun.program
