(** Common types. *)

open Sexplib
open Support.Functors

type sexp = Sexp.t

type var = string [@@deriving sexp]
(** Variable names. *)

module VarSet : SetS.S with type elt = var
module VarMap : MapS.S with type key = var

module Env = VarMap
(** Environments. *)

(** Jump labels. *)
type label = Label of string [@@deriving sexp]

(** Registers. *)
type reg =
  | Rsp
  | Rbp
  | Rax
  | Rbx
  | Rcx
  | Rdx
  | Rsi
  | Rdi
  | R8
  | R9
  | R10
  | R11
  | R12
  | R13
  | R14
  | R15
[@@deriving sexp]

val string_of_reg : reg -> string
(** Convert a register to a string. *)

(** Types. *)
type ty = Integer [@@deriving sexp]
