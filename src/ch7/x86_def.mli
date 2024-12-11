(** x86_def assembly language. *)

open Types

(** Arguments. *)
type arg =
  | Imm       of int
  | Reg       of reg
  | ByteReg   of bytereg
  | Deref     of reg * int
  | GlobalArg of label      (* address of label, offset by %rip register *)
[@@deriving sexp]

(** Instructions. *)
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
  | Leaq          of arg * arg     (* new *)
  | Callq         of label * int   (* int = arity of the call *)
  | IndirectCallq of arg * int     (* new *)
  | Retq
  | Jmp           of label
  | JmpIf         of cc * label
  | TailJmp       of arg * int     (* new *)
[@@deriving sexp]

(** Blocks. *)
type block =
  Block of instr list
[@@deriving sexp]

(** Functions. *)
type fun_contents =
  {
    nparams : int;
    locals  : (var * ty) list;
    body    : (label * block) list;
  }
[@@deriving sexp]

(** Function info type: 
    - number of spilled variables
    - number of variables spilled to the root stack
    - set of callee-saved registers *)
type finfo = Finfo of 
  { 
    num_spilled      : int;
    num_spilled_root : int;
    used_callee      : RegSet.t
  }
[@@deriving sexp]

(** Definitions. *)
type def =
  | Def of label * finfo * fun_contents
[@@deriving sexp]

(** Programs. *)
type program =
  X86Program of def list
[@@deriving sexp]

