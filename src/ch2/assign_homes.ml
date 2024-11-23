open Support
open Utils
open Types
open X86_var

let rec assign_stack (locals_types : (int * (var * ty)) list)
    (dict : (Types.reg * int) VarMap.t) : (reg * int) VarMap.t =
  match locals_types with
  | [] ->
      dict
  | (idx, (v, _)) :: locals_types ->
      let dict = VarMap.add v (Rbp, -(idx + 1) * 8) dict in
      assign_stack locals_types dict

let replace_arg (a : arg) (dict : (reg * int) VarMap.t) : arg =
  match a with
  | Var v ->
      let r, a = VarMap.find v dict in
      Deref (r, a)
  | _ ->
      a

let replace_vars (i : instr) dict : instr =
  match i with
  | Addq (a1, a2) ->
      Addq (replace_arg a1 dict, replace_arg a2 dict)
  | Subq (a1, a2) ->
      Subq (replace_arg a1 dict, replace_arg a2 dict)
  | Negq a ->
      Negq (replace_arg a dict)
  | Movq (a1, a2) ->
      Movq (replace_arg a1 dict, replace_arg a2 dict)
  | Pushq a ->
      Pushq (replace_arg a dict)
  | Popq a ->
      Popq (replace_arg a dict)
  | Callq (l, v) ->
      Callq (l, v)
  | Retq ->
      Retq
  | Jmp l ->
      Jmp l

let transform_program (p : label * block) dict : label * block =
  match p with
  | Label l, Block b ->
      (Label l, Block (List.map (fun e -> replace_vars e dict) b))

let assign_homes (prog : info1 program) : info2 program =
  match prog with
  | X86Program (Info1 {locals_types}, p) ->
      let aligned_stack_space = align_16 (8 * List.length locals_types) in
      let dict =
        assign_stack (List.mapi (fun i v -> (i, v)) locals_types) VarMap.empty
      in
      let new_program = List.map (fun e -> transform_program e dict) p in
      X86Program (Info2 {stack_space = aligned_stack_space}, new_program)
