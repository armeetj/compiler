open X86_asm

(* Return `false` if an instruction has no effect.
   This makes it easy to filter them out. *)
let has_effect = function
  | Addq (Imm 0, Reg _)
   |Addq (Reg _, Imm 0)
   |Subq (Imm 0, Reg _) ->
    false
  | Movq (Reg r1, Reg r2) when r1 = r2 -> false
  | _ -> true

(* Remove the second of a pair of reciprocal moves
   i.e. `movq X Y` followed by `movq Y X`.
   Also remove the second `movq` if it's identical to the first. *)
let trim_reciprocal_moves (ins : instr list) : instr list =
  let fn acc ins =
    match (acc, ins) with
    | Movq (x, y) :: _, Movq (x', y')
      when (x = y' && y = x') || (x = x' && y = y') ->
      (* don't add this ins, and just return acc *)
      acc
    (* prepend instr to acc *)
    | _ -> ins :: acc
  in
  (* we have to fold_left since statements are logically in-order *)
  let aux = List.fold_left fn [] ins in
  (* rev since new ins were prepended, not appended *)
  List.rev aux

let optimize (prog : program) : program =
  let (X86Program instrs) = prog in
  let instrs' = instrs |> List.filter has_effect |> trim_reciprocal_moves in
  X86Program instrs'
