open Support
open Types
open Utils
module C = Cfun
open X86_var_def

(* NOTE: `fix_label` is needed for global variables as well as functions.
   MacOS, for instance, puts `_` before the names of both in assembly code. *)
let make_tuple_tag (len : int) (vec : ty array) : int =
  if len < 0 || len > 50 then failwith "vector length not between 0 and 50"
  else
    let pointer_bits =
      Array.fold_left
        (fun acc ty ->
          let bit =
            match ty with
            | Vector _ -> 1
            | _ -> 0
          in
          (acc * 2) + bit )
        0 vec
    in
    let length_bits = len * 2 in
    let forwarding_bit = 1 in
    let tag = (pointer_bits * 128) + length_bits + forwarding_bit in
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
    | `Negate, [atm] -> [Movq (process_atm atm, Reg Rax); Negq (Reg Rax)]
    | `Not, [atm] -> [Movq (process_atm atm, Reg Rax); Xorq (Imm 1, Reg Rax)]
    | _ -> failwith "shouldn't reach" )
  | Allocate (len, Vector types) ->
    let tag = make_tuple_tag len types in
    [ Movq (GlobalArg (Label "free_ptr"), Reg R11)
    ; Addq (Imm ((8 * len) + 8), GlobalArg (Label "free_ptr"))
    ; Movq (Imm tag, Deref (R11, 0))
    ; Movq (Reg R11, Reg Rax) ]
  | Allocate (len, _) ->
    [ Movq (GlobalArg (Label "free_ptr"), Reg R11)
    ; Addq (Imm ((8 * len) + 8), GlobalArg (Label "free_ptr"))
    ; Movq (Imm 0, Deref (R11, 0))
    ; Movq (Reg R11, Reg Rax) ]
  | GlobalVal var -> [Movq (GlobalArg (Label var), Reg Rax)]
  | VecLen atm ->
    [Movq (process_atm atm, Reg R11); Movq (Deref (R11, -8), Reg Rax)]
  | VecRef (atm, int) ->
    [Movq (process_atm atm, Reg R11); Movq (Deref (R11, (8 * int) + 8), Reg Rax)]
  | VecSet (atm1, i, atm2) ->
    [ Movq (process_atm atm1, Reg R11)
    ; Movq (process_atm atm2, Deref (R11, (8 * i) + 8))
    ; Movq (Reg R11, Reg Rax) ]
  | FunRef (lbl, _) -> [Leaq (GlobalArg lbl, Reg Rax)]
  | C.Call (a', a_list') ->
    let call_arg_moves =
      List.mapi
        (fun i atm -> Movq (process_atm atm, Reg (List.nth arg_passing_regs i)))
        a_list'
    in
    call_arg_moves
    @ [ IndirectCallq (process_atm a', List.length a_list')
      ; Movq (Reg Rax, Reg Rax) ]

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
    | (#cmp_op as op), [atm1; atm2] ->
      [ Cmpq (process_atm atm2, process_atm atm1)
      ; Set (cc_of_op op, ByteReg Al)
      ; Movzbq (ByteReg Al, Var v) ]
    | _ -> failwith "shouldn't reach" )
  | Assign (v, C.VecSet (atm1, i, atm2)) ->
    [ Movq (process_atm atm1, Reg R11)
    ; Movq (process_atm atm2, Deref (R11, (8 * i) + 8))
    ; Movq (Imm 0, Var v) ]
  | Assign (v, C.Allocate (len, Vector types)) ->
    let tag = make_tuple_tag len types in
    [ Movq (GlobalArg (Label "free_ptr"), Reg R11)
    ; Addq (Imm ((8 * len) + 8), GlobalArg (Label "free_ptr"))
    ; Movq (Imm tag, Deref (R11, 0))
    ; Movq (Reg R11, Var v) ]
  | Assign (v, C.Allocate (len, _)) ->
    [ Movq (GlobalArg (Label "free_ptr"), Reg R11)
    ; Addq (Imm ((8 * len) + 8), GlobalArg (Label "free_ptr"))
    ; Movq (Imm 0, Deref (R11, 0))
    ; Movq (Reg R11, Var v) ]
  | Assign (v, C.VecRef (atm, int)) ->
    [Movq (process_atm atm, Reg R11); Movq (Deref (R11, (8 * int) + 8), Var v)]
  | Assign (v, C.GlobalVal var) -> [Movq (GlobalArg (Label var), Var v)]
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
    ; Callq (Label (fix_label "collect"), 2) ]
  | C.Assign (v, C.FunRef (lbl, _)) -> [Leaq (GlobalArg lbl, Var v)]
  | C.Assign (v, C.Call (a', a_list')) ->
    let arg_setup_instrs =
      List.mapi
        (fun i atm -> Movq (process_atm atm, Reg (List.nth arg_passing_regs i)))
        a_list'
    in
    let call_instr = IndirectCallq (process_atm a', List.length a_list') in
    let move_result = Movq (Reg Rax, Var v) in
    arg_setup_instrs @ [call_instr; move_result]
  | C.CallS (a', a_list') ->
    let call_arg_moves =
      List.mapi
        (fun i atm -> Movq (process_atm atm, Reg (List.nth arg_passing_regs i)))
        a_list'
    in
    call_arg_moves @ [IndirectCallq (process_atm a', List.length a_list')]

let rec tail_instructions (f_lbl : label) (i : C.tail) : instr list =
  match i with
  | C.Return exp -> (
    match exp with
    | Call _ -> failwith "tail_instrs: can't return call"
    | _ ->
      process_exp exp @ [Jmp (Label (string_of_label f_lbl ^ "_conclusion"))] )
  | C.Seq (stmt, tail) -> process_stmt stmt @ tail_instructions f_lbl tail
  | C.Goto label -> [Jmp label]
  | C.IfStmt {op; arg1; arg2; jump_then; jump_else} ->
    [ Cmpq (process_atm arg2, process_atm arg1)
    ; JmpIf (Types.cc_of_op op, jump_then)
    ; Jmp jump_else ]
  | C.TailCall (a', a_list') ->
    let call_arg_moves =
      List.mapi
        (fun i atm -> Movq (process_atm atm, Reg (List.nth arg_passing_regs i)))
        a_list'
    in
    call_arg_moves @ [TailJmp (process_atm a', List.length a_list')]

let convert_lt (f_lbl : label) (lt : label * C.tail) : label * binfo1 block =
  let lbl, tail = lt in
  let block = Block (Binfo1, tail_instructions f_lbl tail) in
  (lbl, block)

(*** New for chapter 7 ***)
(* Add argument passing instructions to the front of `start` blocks only.
   All other blocks are unchanged.
   See section 7.8 (p. 139) in the book.
   Also change the `start` block label to `FNAME_start`,
   where FNAME is `f_lbl`.
   `nparams` is the length of the `args` list.
*)
let add_arg_instrs (f_lbl : label) (nparams : int) (args : (var * ty) list)
  (body : (label * binfo1 block) list) : (label * binfo1 block) list =
  if nparams > 6 then
    failwith "compiler error: add_arg_instrs: too many arguments"
  else
    let arg_movq_instrs =
      List.mapi
        (fun i (v, _) -> Movq (Reg (List.nth arg_passing_regs i), Var v))
        args
    in
    List.map
      (fun block ->
        match block with
        | Label "start", Block (binfo, instrs) ->
          ( Label (string_of_label f_lbl ^ "_start")
          , Block (binfo, arg_movq_instrs @ instrs) )
        | _ -> block )
      body

let select_instructions_def (d : C.def) : (finfo1, binfo1) def =
  let (C.Def (f_lbl, fcont)) = d in
  let C.{args; locals; body; _} = fcont in
  let body' = List.map (convert_lt f_lbl) body in
  let nparams = List.length args in
  let body'' = add_arg_instrs f_lbl nparams args body' in
  (* Make the argument variables into local variables. *)
  let locals' = args @ locals in
  let fcont' = {nparams; locals = locals'; body = body''} in
  (* We don't change `f_lbl` here because we will use it in
     `prelude_conclusion.ml` to generate
     the `FNAME_main` and `FNAME_conclusion` labels,
     as well as fixing the `FNAME_main` label. *)
  Def (f_lbl, Finfo1, fcont')

let select_instructions (prog : C.program) : (finfo1, binfo1) program =
  let (C.CProgram defs) = prog in
  X86Program (List.map select_instructions_def defs)
