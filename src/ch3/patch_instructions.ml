open Types
open X86_int
module X = X86_var

let convert_arg (a : X.arg) : arg =
  match a with
  | X.Imm i ->
      Imm i
  | X.Reg r ->
      Reg r
  | X.Deref (r, i) ->
      Deref (r, i)
  | X.Var _ ->
      failwith "convert_arg: we got rid of all Var's after in assign homes"

let convert_instr (i : X.instr) : instr list =
  match i with
  | X.Addq (X.Deref (r1, a1), X.Deref (r2, a2)) ->
      let copy_instr = Movq (Deref (r1, a1), Reg Rax) in
      let comp_instr = Addq (Reg Rax, Deref (r2, a2)) in
      [copy_instr; comp_instr]
  | X.Subq (X.Deref (r1, a1), X.Deref (r2, a2)) ->
      let copy_instr = Movq (Deref (r1, a1), Reg Rax) in
      let comp_instr = Subq (Reg Rax, Deref (r2, a2)) in
      [copy_instr; comp_instr]
  | X.Movq (X.Deref (r1, a1), X.Deref (r2, a2)) ->
      if compare a1 a2 <> 0 then
        let instr1 = Movq (Deref (r1, a1), Reg Rax) in
        let instr2 = Movq (Reg Rax, Deref (r2, a2)) in
        [instr1; instr2]
      else []
  | X.Addq (a1, a2) ->
      [Addq (convert_arg a1, convert_arg a2)]
  | X.Subq (a1, a2) ->
      [Subq (convert_arg a1, convert_arg a2)]
  | X.Movq (a1, a2) when a1 = a2 ->
      []
  | X.Movq (a1, a2) ->
      [Movq (convert_arg a1, convert_arg a2)]
  | X.Negq a ->
      [Negq (convert_arg a)]
  | X.Pushq a ->
      [Pushq (convert_arg a)]
  | X.Callq (l, i) ->
      [Callq (l, i)]
  | X.Popq a ->
      [Popq (convert_arg a)]
  | X.Retq ->
      [Retq]
  | X.Jmp l ->
      [Jmp l]

let convert_block (b : X.binfo1 X.block) : block =
  match b with
  | Block (_, block) ->
      Block (List.map convert_instr block |> List.flatten)

let convert_info (i : X.info3) : info =
  let (X.Info3 info) = i in
  Info
    { locals_types = info.locals_types
    ; num_spilled = info.num_spilled
    ; used_callee = info.used_callee }

let patch_instructions (prog : (X.info3, X.binfo1) X.program) : program =
  let (X.X86Program (info, lbs)) = prog in
  let info' = convert_info info in
  let lbs' = List.map (fun (lbl, block) -> (lbl, convert_block block)) lbs in
  X86Program (info', lbs')
