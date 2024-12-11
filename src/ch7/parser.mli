(** Parser from source language to Lfun AST. *)

open Sexplib

(** Parse a list of S-expressions containing an Lfun program
    to the Lfun AST for a program. *)
val parse_from_sexps : Sexp.t list -> Lfun.program

(** Parse a file containing an Lfun program to
    the Lfun AST for a program.
    The argument is a filename. *)
val parse : string -> Lfun.program

