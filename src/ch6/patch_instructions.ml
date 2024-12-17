open Types
open X86_global
module X = X86_var_global

let convert_arg (a : X.arg) : arg =
  match a with
  | X.Imm i -> Imm i
  | X.Reg r -> Reg r
  | X.Deref (r, i) -> Deref (r, i)
  | X.ByteReg b -> ByteReg b
  | X.GlobalArg l -> GlobalArg l
  | X.Var _ -> failwith "We got rid of all Var's after in assign homes"

let is_reference a =
  match convert_arg a with
  | Deref _
   |GlobalArg _ ->
    true
  | _ -> false

let convert_instr (i : X.instr) : instr list =
  match i with
  | X.Addq (a1, a2)
   |X.Subq (a1, a2)
   |X.Movq (a1, a2)
    when convert_arg a1 = convert_arg a2 ->
    []
  | X.Addq (a1, a2) when is_reference a1 && is_reference a2 ->
    let copy_instr = Movq (convert_arg a1, Reg Rax) in
    let comp_instr = Addq (Reg Rax, convert_arg a2) in
    [copy_instr; comp_instr]
  | X.Subq (a1, a2) when is_reference a1 && is_reference a2 ->
    let copy_instr = Movq (convert_arg a1, Reg Rax) in
    let comp_instr = Subq (Reg Rax, convert_arg a2) in
    [copy_instr; comp_instr]
  | X.Movq (a1, a2) when is_reference a1 && is_reference a2 ->
    let instr1 = Movq (convert_arg a1, Reg Rax) in
    let instr2 = Movq (Reg Rax, convert_arg a2) in
    [instr1; instr2]
  | X.Addq (a1, a2) -> [Addq (convert_arg a1, convert_arg a2)]
  | X.Subq (a1, a2) -> [Subq (convert_arg a1, convert_arg a2)]
  | X.Andq (a1, a2) -> [Andq (convert_arg a1, convert_arg a2)]
  | X.Sarq (a1, a2) -> [Sarq (convert_arg a1, convert_arg a2)]
  | X.Movq (a1, a2) -> [Movq (convert_arg a1, convert_arg a2)]
  | X.Negq a -> [Negq (convert_arg a)]
  | X.Pushq a -> [Pushq (convert_arg a)]
  | X.Callq (l, i) -> [Callq (l, i)]
  | X.Popq a -> [Popq (convert_arg a)]
  | X.Retq -> [Retq]
  | X.Jmp l -> [Jmp l]
  | X.JmpIf (cc, l) -> [JmpIf (cc, l)]
  | X.Set (cc, a) -> (
    match a with
    | X.ByteReg _ -> [Set (cc, convert_arg a)]
    | _ -> failwith "arg should be a byte register" )
  | X.Movzbq (a1, a2) -> (
    match (a1, a2) with
    | X.ByteReg _, X.Reg _ -> [Movzbq (convert_arg a1, convert_arg a2)]
    | X.ByteReg _, _ ->
      [Movzbq (convert_arg a1, Reg Rax); Movq (Reg Rax, convert_arg a2)]
    | _ -> failwith "the first arg of movzbq should be a byte register" )
  | X.Xorq (a1, a2) -> (
    match (a1, a2) with
    | X.Deref _, X.Deref _ ->
      [Movq (convert_arg a1, Reg Rax); Xorq (Reg Rax, convert_arg a2)]
    | _ -> [Xorq (convert_arg a1, convert_arg a2)] )
  | X.Cmpq (a1, a2) -> (
    match (a1, a2) with
    | _, X.Imm _ ->
      [Movq (convert_arg a2, Reg Rax); Cmpq (convert_arg a1, Reg Rax)]
    | X.Deref _, X.Deref _ ->
      [Movq (convert_arg a1, Reg Rax); Cmpq (Reg Rax, convert_arg a2)]
    | _ -> [Cmpq (convert_arg a1, convert_arg a2)] )

let convert_block (b : X.binfo1 X.block) : block =
  match b with
  | Block (_, block) -> Block (List.map convert_instr block |> List.flatten)

let convert_info (i : X.info3) : info =
  let (X.Info3 info) = i in
  Info
    { locals_types = info.locals_types
    ; num_spilled = info.num_spilled
    ; num_spilled_root = info.num_spilled_root
    ; used_callee = info.used_callee }

let patch_instructions (prog : (X.info3, X.binfo1) X.program) : program =
  let (X.X86Program (info, lbs)) = prog in
  let info' = convert_info info in
  let lbs' = List.map (fun (lbl, block) -> (lbl, convert_block block)) lbs in
  X86Program (info', lbs')
