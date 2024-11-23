open Sexplib
open Sexplib.Std
open Types

type arg =
  | Imm of int
  | Reg of reg
  | ByteReg of bytereg
  | Deref of reg * int
  | GlobalArg of label
  | Var of var
[@@deriving sexp]

type instr =
  | Addq of arg * arg
  | Subq of arg * arg
  | Negq of arg
  | Xorq of arg * arg
  | Cmpq of arg * arg
  | Andq of arg * arg
  | Sarq of arg * arg
  | Set of cc * arg
  | Movq of arg * arg
  | Movzbq of arg * arg
  | Pushq of arg
  | Popq of arg
  | Callq of label * int (* int = arity of the call *)
  | Retq
  | Jmp of label
  | JmpIf of cc * label
[@@deriving sexp]

let string_of_instr i = Sexp.to_string (sexp_of_instr i)

type 'a block = Block of 'a * instr list [@@deriving sexp]

type ('a, 'b) program = X86Program of 'a * (label * 'b block) list
[@@deriving sexp]

type binfo1 = Binfo1 [@@deriving sexp]

type live = {initial : LocSet.t; afters : LocSet.t list} [@@deriving sexp]

type binfo2 = Binfo2 of live [@@deriving sexp]

type info1 = Info1 of {locals_types : (var * ty) list} [@@deriving sexp]

type info2 = Info2 of {locals_types : (var * ty) list; conflicts : LocUgraph.t}
[@@deriving sexp]

type info3 =
  | Info3 of
      { locals_types : (var * ty) list
      ; num_spilled : int
      ; num_spilled_root : int
      ; used_callee : RegSet.t }
[@@deriving sexp]
