(** "Explicate-control" pass. 
    Flatten `let`s into a series of assignment statements. *)

val explicate_control : Lif_mon.program -> Cif.program
