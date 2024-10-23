(** Parser from source language to Lvar AST. *)

(** Parse a file containing an Lvar program to
    the Lvar AST for a program.
    The argument is a filename. *)
val parse : string -> Lvar.program
