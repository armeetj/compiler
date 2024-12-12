(* ch6 *)
open Support
open Types
open Utils
module C = Ctup
open X86_var_global

(* NOTE: `fix_label` is needed for global variables as well as functions.
   MacOS, for instance, puts `_` before the names of both in assembly code. *)
let make_tuple_tag (len : int) (vec : ty array) : int =
  if len < 0 || len > 50 then failwith "Vector length must be between 0 and 50" ;
  let pointer_bits =
    Array.fold_left
      (fun acc ty ->
        let bit = match ty with Vector _ -> 1 | _ -> 0 in
        (acc lsl 1) lor bit )
      0 vec
  in
  let length_bits = len lsl 1 in
  let forwarding_bit = 1 in
  let tag = (pointer_bits lsl 7) lor length_bits lor forwarding_bit in
  tag

let process_atm atm =
  match atm with
  | C.Int i -> Imm i
  | C.Var v -> Var v
  | C.Bool b -> if b = false then Imm 0 else Imm 1
  | Void -> Imm 0

let process_exp (exp : C.exp) : instr list =
  match exp with
  | C.Atm atm -> [Movq (process_atm atm, Reg Rax)]
  | C.Prim (cop, al) -> (
    match (cop, al) with
    | `Read, [] -> [Callq (Label (fix_label "read_int"), 0)]
    | `Add, [atm1; atm2] ->
      [Movq (process_atm atm1, Reg Rax); Addq (process_atm atm2, Reg Rax)]
    | `Sub, [atm1; atm2] ->
        [Movq (process_atm atm1, Reg Rax); Subq (process_atm atm2, Reg Rax)]
    | `Negate, [atm] ->
        [Movq (process_atm atm, Reg Rax); Negq (Reg Rax)]
    | `Not, [atm] ->
        [Movq (process_atm atm, Reg Rax); Xorq (Imm 1, Reg Rax)]
    | _ ->
        failwith "shouldn't reach" )
  | Allocate (len, Vector types) ->
      let tag = make_tuple_tag len types in
      [ Movq (GlobalArg (Label (fix_label "free_ptr")), Reg R11)
      ; Addq (Imm ((8 * len) + 8), GlobalArg (Label (fix_label "free_ptr")))
      ; Movq (Imm tag, Deref (R11, 0))
      ; Movq (Reg R11, Reg Rax) ]
  | Allocate (len, _) ->
      [ Movq (GlobalArg (Label (fix_label "free_ptr")), Reg R11)
      ; Addq (Imm ((8 * len) + 8), GlobalArg (Label (fix_label "free_ptr")))
      ; Movq (Imm 0, Deref (R11, 0))
      ; Movq (Reg R11, Reg Rax) ]
  | GlobalVal var ->
      [Movq (GlobalArg (Label var), Reg Rax)]
  | VecLen atm ->
      [Movq (process_atm atm, Reg R11); Movq (Deref (R11, -8), Reg Rax)]
  | VecRef (atm, int) ->
      [ Movq (process_atm atm, Reg R11)
      ; Movq (Deref (R11, (8 * int) + 8), Reg Rax) ]
  | VecSet (atm1, i, atm2) ->
      [ Movq (process_atm atm1, Reg R11)
      ; Movq (process_atm atm2, Deref (R11, (8 * i) + 8))
      ; Movq (Reg R11, Reg Rax) ]

let process_stmt stmt : instr list =
  match stmt with
  | C.PrimS (stmt_op, atm_lst) -> (
    match (stmt_op, atm_lst) with
    | `Read, [] -> [Callq (Label (fix_label "read_int"), 0)]
    | `Print, [arg] ->
      [Movq (process_atm arg, Reg Rdi); Callq (Label (fix_label "print_int"), 0)]
    | _ -> failwith "shouldn't reach" )
  | C.Assign (v, C.Atm atm) -> [Movq (process_atm atm, Var v)]
  | C.Assign (v, C.Prim (cop, al)) -> (
    match (cop, al) with
    | `Read, [] ->
      [Callq (Label (fix_label "read_int"), 0); Movq (Reg Rax, Var v)]
    | `Add, [atm1; atm2] ->
      [Movq (process_atm atm1, Var v); Addq (process_atm atm2, Var v)]
    | `Sub, [atm1; atm2] ->
      [Movq (process_atm atm1, Var v); Subq (process_atm atm2, Var v)]
    | `Negate, [atm] -> [Movq (process_atm atm, Var v); Negq (Var v)]
    | `Not, [atm] -> [Movq (process_atm atm, Var v); Xorq (Imm 1, Var v)]
    | `Eq, [atm1; atm2] ->
      [ Cmpq (process_atm atm2, process_atm atm1)
      ; Set (CC_e, ByteReg Al)
      ; Movzbq (ByteReg Al, Var v) ]
    | `Lt, [atm1; atm2] ->
      [ Cmpq (process_atm atm2, process_atm atm1)
      ; Set (CC_l, ByteReg Al)
      ; Movzbq (ByteReg Al, Var v) ]
    | `Le, [atm1; atm2] ->
      [ Cmpq (process_atm atm2, process_atm atm1)
      ; Set (CC_le, ByteReg Al)
      ; Movzbq (ByteReg Al, Var v) ]
    | `Gt, [atm1; atm2] ->
      [ Cmpq (process_atm atm2, process_atm atm1)
      ; Set (CC_g, ByteReg Al)
      ; Movzbq (ByteReg Al, Var v) ]
    | `Ge, [atm1; atm2] ->
        [ Cmpq (process_atm atm2, process_atm atm1)
        ; Set (CC_ge, ByteReg Al)
        ; Movzbq (ByteReg Al, Var v) ]
    | _ ->
        failwith "shouldn't reach" )
  | Assign (v, C.VecSet (atm1, i, atm2)) ->
      [ Movq (process_atm atm1, Reg R11)
      ; Movq (process_atm atm2, Deref (R11, (8 * i) + 8))
      ; Movq (Imm 0, Var v) ]
  | Assign (v, C.Allocate (len, Vector types)) ->
      let tag = make_tuple_tag len types in
      [ Movq (GlobalArg (Label (fix_label "free_ptr")), Reg R11)
      ; Addq (Imm ((8 * len) + 8), GlobalArg (Label (fix_label "free_ptr")))
      ; Movq (Imm tag, Deref (R11, 0))
      ; Movq (Reg R11, Var v) ]
  | Assign (v, C.Allocate (len, _)) ->
      [ Movq (GlobalArg (Label (fix_label "free_ptr")), Reg R11)
      ; Addq (Imm ((8 * len) + 8), GlobalArg (Label (fix_label "free_ptr")))
      ; Movq (Imm 0, Deref (R11, 0))
      ; Movq (Reg R11, Var v) ]
  | Assign (v, C.VecRef (atm, int)) ->
      [Movq (process_atm atm, Reg R11); Movq (Deref (R11, (8 * int) + 8), Var v)]
  | Assign (v, C.GlobalVal var) ->
      [Movq (GlobalArg (Label var), Var v)]
  | Assign (v, C.VecLen atm) ->
      [ Movq (process_atm atm, Reg R11)
      ; Movq (Deref (R11, 0), Reg Rax)
      ; Andq (Imm 126, Reg Rax)
      ; Sarq (Imm 1, Reg Rax)
      ; Movq (Reg Rax, Var v) ]
  | VecSetS (atm1, i, atm2) ->
      [ Movq (process_atm atm1, Reg R11)
      ; Movq (process_atm atm2, Deref (R11, (8 * i) + 8)) ]
  | Collect i ->
      [ Movq (Reg R15, Reg Rdi)
      ; Movq (Imm i, Reg Rsi)
      ; Callq (Label "collect", 2) ]

let rec tail_instructions (i : C.tail) : instr list =
  match i with
  | C.Return exp -> process_exp exp @ [Jmp (Label "conclusion")]
  | C.Seq (stmt, tail) -> process_stmt stmt @ tail_instructions tail
  | C.Goto label -> [Jmp label]
  | C.IfStmt {op; arg1; arg2; jump_then; jump_else} ->
    [ Cmpq (process_atm arg2, process_atm arg1)
    ; JmpIf (Types.cc_of_op op, jump_then)
    ; Jmp jump_else ]

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
