(** "Shrink" pass: rewrite `and` and `or` forms in terms of `if`. *)

val shrink : Lwhile.program -> Lwhile_shrink.program
