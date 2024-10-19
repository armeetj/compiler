(** Parser from source language to Lvar AST. *)

val parse : string -> Lvar.program
(** Parse a file containing an Lvar program to
    the Lvar AST for a program.
    The argument is a filename. *)
