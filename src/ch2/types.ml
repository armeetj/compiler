open Sexplib
open Sexplib.Std
open Support.Functors

type sexp = Sexp.t

(* ----------------------------------------------------------------------
 * Variables.
 * ---------------------------------------------------------------------- *)

type var = string [@@deriving sexp]

module OrderedVarS = struct
  type t = var

  let compare = Stdlib.compare

  let t_of_sexp = var_of_sexp

  let sexp_of_t = sexp_of_var

  let to_string v = v
end

module VarSet = SetS.Make (OrderedVarS)
module VarMap = MapS.Make (OrderedVarS)

(* ----------------------------------------------------------------------
 * Environments.
 * ---------------------------------------------------------------------- *)

module Env = VarMap

(* ----------------------------------------------------------------------
 * Labels.
 * ---------------------------------------------------------------------- *)

type label = Label of string [@@deriving sexp]

(* ----------------------------------------------------------------------
 * Registers.
 * ---------------------------------------------------------------------- *)

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

let string_of_reg = function
  | Rsp ->
      "rsp"
  | Rbp ->
      "rbp"
  | Rax ->
      "rax"
  | Rbx ->
      "rbx"
  | Rcx ->
      "rcx"
  | Rdx ->
      "rdx"
  | Rsi ->
      "rsi"
  | Rdi ->
      "rdi"
  | R8 ->
      "r8"
  | R9 ->
      "r9"
  | R10 ->
      "r10"
  | R11 ->
      "r11"
  | R12 ->
      "r12"
  | R13 ->
      "r13"
  | R14 ->
      "r14"
  | R15 ->
      "r15"

(* ----------------------------------------------------------------------
 * (Language-level) types.
 * ---------------------------------------------------------------------- *)

type ty = Integer [@@deriving sexp]
