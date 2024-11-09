(** "Shrink" pass: rewrite `and` and `or` forms in terms of `if`. *)

val shrink : Lif.program -> Lif_shrink.program
