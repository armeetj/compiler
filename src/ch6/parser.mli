(** Parser from source language to Ltup AST. *)

open Sexplib

(** Parse an S-expression containing an Ltup program
    to the Ltup AST for a program. *)
val parse_from_sexp : Sexp.t -> Ltup.program

(** Parse a file containing an Ltup program to
    the Ltup AST for a program.
    The argument is a filename. *)
val parse : string -> Ltup.program

