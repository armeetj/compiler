(** x86_var_def pseudo-assembly language. *)

open Types

(** Arguments. *)
type arg =
  | Imm of int
  | Reg of reg
  | ByteReg of bytereg
  | Deref of reg * int
  | GlobalArg of label (* address of label, offset by %rip register *)
  | Var of var
[@@deriving sexp]

(** Instructions. *)
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
  | Leaq of arg * arg (* new *)
  | Callq of label * int (* int = arity of the call *)
  | IndirectCallq of arg * int (* new *)
  | Retq
  | Jmp of label
  | JmpIf of cc * label
  | TailJmp of arg * int (* new; int = arity of the tail call *)
[@@deriving sexp]

val string_of_instr : instr -> string

(** A block type parameterized over a block info type. *)
type 'a block = Block of 'a * instr list [@@deriving sexp]

(** Functions, parameterized over a block info type. *)
type 'a fun_contents =
  {nparams : int; locals : (var * ty) list; body : (label * 'a block) list}
[@@deriving sexp]

(** Definitions, each of which is parameterized over:
    - a function info type ('a)
    - a block info type ('b)
 *)
type ('a, 'b) def = Def of label * 'a * 'b fun_contents [@@deriving sexp]

(** A program type parameterized over block and program info. *)
type ('a, 'b) program = X86Program of ('a, 'b) def list [@@deriving sexp]

(** First block info type: a placeholder. *)
type binfo1 = Binfo1 [@@deriving sexp]

(** Liveness data for a block. *)
type live =
  { initial : LocSet.t (* initial live variables/registers *)
  ; afters : LocSet.t list (* live vars/regs after each instruction *) }
[@@deriving sexp]

(** Second block info type: liveness sets. *)
type binfo2 = Binfo2 of live [@@deriving sexp]

(** First function info type: a placeholder. *)
type finfo1 = Finfo1 [@@deriving sexp]

(** Second function info type: the interference graph. *)
type finfo2 = Finfo2 of {conflicts : LocUgraph.t} [@@deriving sexp]

(** Third function info type: 
    - number of spilled variables
    - number of variables spilled to the root stack
    - set of callee-saved registers *)
type finfo3 =
  | Finfo3 of {num_spilled : int; num_spilled_root : int; used_callee : RegSet.t}
[@@deriving sexp]
