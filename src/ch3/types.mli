(** Common types. *)

open Support
open Functors

module IntSet : SetS.S with type elt = int
module IntMap : MapS.S with type key = int

(** Variable names. *)
type var = string
[@@deriving sexp]

module VarSet : SetS.S with type elt = var
module VarMap : MapS.S with type key = var

(** Environments. *)
module Env = VarMap

(** Jump labels. *)
type label = Label of string
[@@deriving sexp]

module LabelMap : MapS.S with type key = label

(** Convert a label to a string. *)
val string_of_label : label -> string

(** Registers. *)
type reg =
  | Rsp | Rbp | Rax | Rbx | Rcx | Rdx | Rsi | Rdi
  | R8  | R9  | R10 | R11 | R12 | R13 | R14 | R15
[@@deriving sexp]

(** Convert a string to a register. *)
val reg_of_string : string -> reg

(** Convert a string to a list of registers. *)
val reg_list_of_string : string -> reg list

(** Convert a register to a string. *)
val string_of_reg : reg -> string

(** Ordered registers. *)
module OrderedRegS : OrderedTypeS with type t = reg

(** Set of registers. *)
module RegSet : SetS.S with type elt = reg

(** Caller-save registers. *)
val caller_save_regs : RegSet.t

(** Callee-save registers (that we can use). *)
val callee_save_regs : RegSet.t

(** Registers in which arguments can be passed.
    We use a list instead of a set because the order matters;
    arguments are passed in registers in a particular order. *)
val arg_passing_regs : reg list

(** Locations. *)
type location =
  | VarL   of var
  | RegL   of reg
  | StackL of reg * int   (* stack offset location *)
[@@deriving sexp]

(** Convert a location to a string. *)
val string_of_location : location -> string

(** Ordered locations. *)
module OrderedLoc : OrderedTypeS with type t = location

module LocSet : SetS.S with type elt = location
module LocMap : MapS.S with type key = location

(** Undirected graph of locations. *)
module LocUgraph : Ugraph.S with type elt = location

(** Type of types, for use in type checkers. *)
type ty = Integer
[@@deriving sexp]

