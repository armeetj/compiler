(** Parser from source language to Lif AST. *)

open Sexplib

(** Parse an S-expression containing an Lif program
    to the Lif AST for a program. *)
val parse_from_sexp : Sexp.t -> Lif.program

(** Parse a file containing an Lif program to
    the Lif AST for a program.
    The argument is a filename. *)
val parse : string -> Lif.program

