(** x86_if assembly language. *)

open Types

(** Arguments. *)
type arg =
  | Imm     of int
  | Reg     of reg
  | ByteReg of bytereg
  | Deref   of reg * int
[@@deriving sexp]

(** Instructions. *)
type instr = 
  | Addq   of arg * arg
  | Subq   of arg * arg
  | Negq   of arg
  | Xorq   of arg * arg
  | Cmpq   of arg * arg
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
    locals_types : (var * ty) list;
    num_spilled  : int;
    used_callee  : RegSet.t
  }
[@@deriving sexp]

(** Programs *)
type program = 
  X86Program of info * (label * block) list
[@@deriving sexp]
