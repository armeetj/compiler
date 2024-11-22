(** x86_var_global pseudo-assembly language. *)

open Types

(** Arguments. *)
type arg =
  | Imm       of int
  | Reg       of reg
  | ByteReg   of bytereg
  | Deref     of reg * int
  | GlobalArg of label      (* address of label, offset by %rip register *)
  | Var       of var
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

val string_of_instr : instr -> string

(** A block type parameterized over block info. *)
type 'a block =
  Block of 'a * instr list
[@@deriving sexp]

(** A program type parameterized over block and program info. *)
type ('a, 'b) program =
  X86Program of 'a * (label * 'b block) list
[@@deriving sexp]

(** First block info type: a placeholder. *)
type binfo1 = Binfo1
[@@deriving sexp]

(** Liveness data for a block. *)
type live =
  {
    initial : LocSet.t;     (* initial live variables/registers *)
    afters  : LocSet.t list (* live vars/regs after each instruction *)
  }
[@@deriving sexp]

(** Second block info type: liveness sets. *)
type binfo2 = Binfo2 of live
[@@deriving sexp]

(** First program info type: a variable->type map. *)
type info1 = Info1 of { locals_types : (var * ty) list }
[@@deriving sexp]

(** Second program info type, with interference graph. *)
type info2 = Info2 of
  {
    locals_types : (var * ty) list;
    conflicts    : LocUgraph.t
  }
[@@deriving sexp]

(** Third program info type: 
    - variable->type map
    - number of spilled variables
    - number of variables spilled to the root stack
    - set of callee-saved registers *)
type info3 = Info3 of 
  { 
    locals_types     : (var * ty) list;
    num_spilled      : int;
    num_spilled_root : int;
    used_callee      : RegSet.t
  }
[@@deriving sexp]

