(** Parser from source language to Lfun AST. *)

open Sexplib

val parse_from_sexps : Sexp.t list -> Lfun.program
(** Parse a list of S-expressions containing an Lfun program
    to the Lfun AST for a program. *)

val parse : string -> Lfun.program
(** Parse a file containing an Lfun program to
    the Lfun AST for a program.
    The argument is a filename. *)
