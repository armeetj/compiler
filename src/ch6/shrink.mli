(** "Shrink" pass: rewrite `and` and `or` forms in terms of `if`. *)

val shrink : Ltup.program -> Ltup_shrink.program
