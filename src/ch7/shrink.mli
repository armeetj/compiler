(** "Shrink" pass: rewrite `and` and `or` forms in terms of `if`. *)

val shrink : Lfun.program -> Lfun_shrink.program
