open Support
open Types
open Utils
module X = X86_int
open X86_asm

(* Code that has to be added to each program at the end.
   It's parametrized on the stack space. *)
let epilog (ss : int) : instr list =
  let main = fix_label "main" in
  [
    Global (Types.Label main);
    Label main;
    Pushq (Reg Rbp);
    Movq (Reg Rsp, Reg Rbp);
    Subq (Imm ss, Reg Rsp);
    Jmp (Types.Label (fix_label "start"));
    Label (fix_label "conclusion");
    Addq (Imm ss, Reg Rsp);
    Popq (Reg Rbp);
    Retq;
  ]

let convert_arg a =
  match a with
  | X.Imm i -> Imm i
  | X.Reg r -> Reg r
  | X.Deref (r, i) -> Deref (r, i)

let convert_instr b =
  match b with
  | X.Addq (a1, a2) -> Addq (convert_arg a1, convert_arg a2)
  | X.Subq (a1, a2) -> Subq (convert_arg a1, convert_arg a2)
  | X.Negq a -> Negq (convert_arg a)
  | X.Movq (a1, a2) -> Movq (convert_arg a1, convert_arg a2)
  | X.Pushq a -> Pushq (convert_arg a)
  | X.Popq a -> Popq (convert_arg a)
  | X.Callq (Label l, _) -> Callq (Label l)
  | X.Retq -> Retq
  | X.Jmp (Label l) -> Jmp (Label l)

(* Convert a labeled block to a list of instructions. *)
let asm_of_lb (lb : Types.label * X.block) : instr list =
  match lb with Label l, Block b -> Label l :: List.map convert_instr b

let prelude_conclusion (prog : X.program) : program =
  let (X.X86Program (info, lbs)) = prog in
  let (Info { stack_space = ss }) = info in
  let ep = epilog ss in
  let lbs' = List.concat_map asm_of_lb lbs in
  X86Program (lbs' @ ep)
