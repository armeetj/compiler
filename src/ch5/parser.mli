(** Parser from source language to Lwhile AST. *)

open Sexplib

(** Parse an S-expression containing an Lwhile program
    to the Lwhile AST for a program. *)
val parse_from_sexp : Sexp.t -> Lwhile.program

(** Parse a file containing an Lwhile program to
    the Lwhile AST for a program.
    The argument is a filename. *)
val parse : string -> Lwhile.program

