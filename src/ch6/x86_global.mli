(** x86_global assembly language. *)

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
  | Addq   of arg * arg
  | Subq   of arg * arg
  | Negq   of arg
  | Xorq   of arg * arg
  | Cmpq   of arg * arg
  | Andq   of arg * arg     (* new *)
  | Sarq   of arg * arg     (* new *)
  | Set    of cc * arg
  | Movq   of arg * arg
  | Movzbq of arg * arg
  | Pushq  of arg
  | Popq   of arg
  | Callq  of label * int   (* int = arity of the call *)
  | Retq
  | Jmp    of label
  | JmpIf  of cc * label
[@@deriving sexp]

(** Blocks. *)
type block = 
  Block of instr list
[@@deriving sexp]
 
(** Program info type:
    - variable->type map
    - number of spilled variables
    - set of callee-saved registers *)
type info = Info of 
  { 
    locals_types     : (var * ty) list;
    num_spilled      : int;
    num_spilled_root : int;
    used_callee      : RegSet.t
  }
[@@deriving sexp]

(** Programs *)
type program = 
  X86Program of info * (label * block) list
[@@deriving sexp]
