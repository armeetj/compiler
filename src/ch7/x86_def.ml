open Sexplib.Std
open Types

type arg =
  | Imm       of int
  | Reg       of reg
  | ByteReg   of bytereg
  | Deref     of reg * int
  | GlobalArg of label
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

type block =
  Block of instr list
[@@deriving sexp]

type fun_contents =
  {
    nparams : int;
    locals  : (var * ty) list;
    body    : (label * block) list;
  }
[@@deriving sexp]

type finfo = Finfo of 
  { 
    num_spilled      : int;
    num_spilled_root : int;
    used_callee      : RegSet.t
  }
[@@deriving sexp]

type def =
  | Def of label * finfo * fun_contents
[@@deriving sexp]

type program =
  X86Program of def list
[@@deriving sexp]

