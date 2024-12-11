open Sexplib
open Sexplib.Std
open Types

type arg =
  | Imm       of int
  | Reg       of reg
  | ByteReg   of bytereg
  | Deref     of reg * int
  | GlobalArg of label
  | Var       of var
[@@deriving sexp]

type instr =
  | Addq          of arg * arg
  | Subq          of arg * arg
  | Negq          of arg
  | Xorq          of arg * arg
  | Cmpq          of arg * arg
  | Andq          of arg * arg
  | Sarq          of arg * arg
  | Set           of cc * arg
  | Movq          of arg * arg
  | Movzbq        of arg * arg
  | Pushq         of arg
  | Popq          of arg
  | Leaq          of arg * arg
  | Callq         of label * int
  | IndirectCallq of arg * int
  | Retq
  | Jmp           of label
  | JmpIf         of cc * label
  | TailJmp       of arg * int
[@@deriving sexp]

let string_of_instr i = Sexp.to_string (sexp_of_instr i)

type 'a block =
  Block of 'a * instr list
[@@deriving sexp]

type 'a fun_contents =
  {
    nparams : int;
    locals  : (var * ty) list;
    body    : (label * 'a block) list;
  }
[@@deriving sexp]

type ('a, 'b) def =
  | Def of label * 'a * 'b fun_contents
[@@deriving sexp]

type ('a, 'b) program =
  X86Program of ('a, 'b) def list
[@@deriving sexp]

type binfo1 = Binfo1
[@@deriving sexp]

type live =
  {
    initial : LocSet.t;
    afters  : LocSet.t list;
  }
[@@deriving sexp]

type binfo2 = Binfo2 of live
[@@deriving sexp]

type finfo1 = Finfo1
[@@deriving sexp]

type finfo2 = Finfo2 of
  {
    conflicts    : LocUgraph.t
  }
[@@deriving sexp]

type finfo3 = Finfo3 of
  {
    num_spilled      : int;
    num_spilled_root : int;
    used_callee      : RegSet.t
  }
[@@deriving sexp]

