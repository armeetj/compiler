(** Various utility functions. *)

open Sexplib

val some : 'a -> 'a option
(** Make a `Some` value. *)

val satom : string -> Sexp.t
(** Make an S-expression atom. *)

val slist : Sexp.t list -> Sexp.t
(** Make an S-expression list. *)

val align_16 : int -> int
(** Round a number up to the nearest multiple of 16.
    Used for stack alignment. *)

val change_filename_ext :
  filename:string -> ext1:string -> ext2:string -> string
(** Change a filename extension.
    A filename extension is defined as a `.` character followed
    by one or more non-`.` characters to the end of the string.
    If the filename doesn't end with that extension, return it unchanged. *)

val split_on_spaces : string -> string list
(** Split a string on spaces. *)

val string_map : ?sep:string -> ('a -> string) -> 'a list -> string
(** Map a function over a list of strings, concatenating the result.
    The separator defaults to "". *)

val no_string_repeats : string list -> bool
(** Test if a list of strings contains only unique strings. *)

val last : 'a list -> 'a
(** Return the last element of a list. *)

val butlast : 'a list -> 'a list
(** Return all but the last element of a list. *)

val take : int -> 'a list -> 'a list
(** Take `n` values from the front of a list, forming a new list. *)

val drop : int -> 'a list -> 'a list
(** Drop the first `n` values from the front of a list, forming a new list. *)

val range : int -> int -> int list
(** Return a list of numbers from `m` up to and not including `n`. *)

val pretty_print : Sexp.t -> string
(** Convert an S-expression to a string in a nice way. *)

val pp_line_limit : int ref
(** Line breaking limit for S-expression pretty-printer. *)

val pp_indent : int ref
(** Indent for S-expression pretty-printer. *)

val print_sexp : Sexp.t -> unit
(** Print an S-expression to the terminal. *)

val print_sexp_to_file : string -> Sexp.t -> unit
(** Print an S-expression to a file. *)

val make_gensym : unit -> base:string -> sep:string -> string
(** Return a function that generates unique symbols.
    Given a unit value, this returns a gensym function
    that generates new symbols starting with the base symbol. *)

val os_type : unit -> string
(** Return a string representing the OS type. *)

val no_fix_label : bool ref
(** Disable `fix_label` functionality. *)

val fix_label : string -> string
(** Convert a function label into the kind of label the OS requires. *)

val failwithf : ('a, unit, string, 'b) format4 -> 'a
(** A variant of `failwith` that allows `printf`-like formatting. *)
