open Sexplib
open Sexplib.Conv
open Support
open Functors

module OrderedIntS = struct
  type t = int

  let compare = Stdlib.compare

  let t_of_sexp = int_of_sexp

  let sexp_of_t = sexp_of_int

  let to_string = string_of_int
end

module IntSet = SetS.Make (OrderedIntS)
module IntMap = MapS.Make (OrderedIntS)

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

module OrderedLabelS = struct
  type t = label

  let compare = Stdlib.compare

  let t_of_sexp = label_of_sexp

  let sexp_of_t = sexp_of_label

  let to_string (Label s) = s
end

module LabelMap = MapS.Make (OrderedLabelS)

let string_of_label (Label lbl) = lbl

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

module OrderedRegS = struct
  type t = reg

  let compare = Stdlib.compare

  let t_of_sexp = reg_of_sexp

  let sexp_of_t = sexp_of_reg

  let to_string reg =
    String.uncapitalize_ascii (Sexp.to_string (sexp_of_reg reg))
end

module RegSet = SetS.Make (OrderedRegS)

let reg_of_string = function
  | "rsp" ->
      Rsp
  | "rbp" ->
      Rbp
  | "rax" ->
      Rax
  | "rbx" ->
      Rbx
  | "rcx" ->
      Rcx
  | "rdx" ->
      Rdx
  | "rsi" ->
      Rsi
  | "rdi" ->
      Rdi
  | "r8" ->
      R8
  | "r9" ->
      R9
  | "r10" ->
      R10
  | "r11" ->
      R11
  | "r12" ->
      R12
  | "r13" ->
      R13
  | "r14" ->
      R14
  | "r15" ->
      R15
  | _ ->
      failwith "reg_of_string: invalid register"

let reg_list_of_string s =
  s |> String.split_on_char ',' |> List.map reg_of_string

let string_of_reg = OrderedRegS.to_string

let caller_save_regs = RegSet.of_list [Rax; Rcx; Rdx; Rsi; Rdi; R8; R9; R10; R11]

let callee_save_regs = RegSet.of_list [Rbx; R12; R13; R14]

(* Pass arguments in registers in this order (%rdi first etc.). *)
let arg_passing_regs = [Rdi; Rsi; Rdx; Rcx; R8; R9]

(* ----------------------------------------------------------------------
 * Locations.
 * ---------------------------------------------------------------------- *)

type location = VarL of var | RegL of reg | StackL of reg * int
[@@deriving sexp]

let string_of_location l = Sexp.to_string (sexp_of_location l)

module OrderedLoc = struct
  type t = location

  let compare_reg = OrderedRegS.compare

  (* CHECKME: Could this just be Stdlib.compare? *)
  (* NOTE: Vars < Regs < Stack *)
  let compare l1 l2 =
    match (l1, l2) with
    | VarL v1, VarL v2 ->
        Stdlib.compare v1 v2
    | VarL _, RegL _ ->
        -1
    | VarL _, StackL _ ->
        -1
    | RegL _, VarL _ ->
        1
    | RegL r1, RegL r2 ->
        compare_reg r1 r2
    | RegL _, StackL _ ->
        -1
    | StackL _, VarL _ ->
        1
    | StackL _, RegL _ ->
        1
    | StackL (r1, i1), StackL (r2, i2) ->
        let comp_reg = compare_reg r1 r2 in
        if comp_reg = 0 then Stdlib.compare i1 i2 else comp_reg

  let sexp_of_t = sexp_of_location

  let t_of_sexp = location_of_sexp

  let to_string loc = Sexp.to_string (sexp_of_location loc)
end

module LocSet = SetS.Make (OrderedLoc)
module LocMap = MapS.Make (OrderedLoc)
module LocUgraph = Ugraph.Make (OrderedLoc)

(* ----------------------------------------------------------------------
 * (Language-level) types.
 * ---------------------------------------------------------------------- *)

type ty = Integer [@@deriving sexp]
