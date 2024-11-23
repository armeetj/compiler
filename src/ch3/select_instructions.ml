open Support
open Utils
open Types
module C = Cvar
open X86_var

let process_atm atm = match atm with C.Int i -> Imm i | C.Var v -> Var v

(* Dealing with moving things to %Rax *)
let process_exp exp =
  match exp with
  | C.Atm atm ->
      [Movq (process_atm atm, Reg Rax)]
  | C.Read ->
      [Callq (Label (fix_label "read_int"), 0)]
  | C.Negate atm ->
      [Movq (process_atm atm, Reg Rax); Negq (Reg Rax)]
  | C.Add (atm1, atm2) ->
      [Movq (process_atm atm1, Reg Rax); Addq (process_atm atm2, Reg Rax)]
  | C.Sub (atm1, atm2) ->
      [Movq (process_atm atm1, Reg Rax); Subq (process_atm atm2, Reg Rax)]

let process_stmt stmt =
  match stmt with
  | C.Assign (v, C.Atm atm) ->
      [Movq (process_atm atm, Var v)]
  | C.Assign (v, C.Read) ->
      [Callq (Label (fix_label "read_int"), 0); Movq (Reg Rax, Var v)]
  | C.Assign (v, C.Negate atm) ->
      [Movq (process_atm atm, Var v); Negq (Var v)]
  | C.Assign (v, C.Add (atm1, atm2)) ->
      [Movq (process_atm atm1, Var v); Addq (process_atm atm2, Var v)]
  | C.Assign (v, C.Sub (atm1, atm2)) ->
      [Movq (process_atm atm1, Var v); Subq (process_atm atm2, Var v)]

let rec tail_instructions (i : C.tail) : instr list =
  match i with
  | C.Return exp ->
      process_exp exp @ [Jmp (Label "conclusion")]
  | C.Seq (stmt, tail) ->
      process_stmt stmt @ tail_instructions tail

let convert_lt (lt : Types.label * C.tail) : Types.label * binfo1 block =
  let lbl, tail = lt in
  let block = Block (Binfo1, tail_instructions tail) in
  (lbl, block)

let convert_info (info : C.info) : info1 =
  let (C.Info {locals_types = vts}) = info in
  Info1 {locals_types = vts}

let select_instructions (prog : C.program) : (info1, binfo1) program =
  let (C.CProgram (info, lts)) = prog in
  X86Program (convert_info info, List.map convert_lt lts)
