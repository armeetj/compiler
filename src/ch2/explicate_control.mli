(** "Explicate-control" pass. 
    Flatten `let`s into a series of assignment statements. *)

val explicate_control : Lvar_mon.program -> Cvar.program
