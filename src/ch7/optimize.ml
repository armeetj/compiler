open X86_asm

(* Return `false` if an instruction has no effect.
   This makes it easy to filter them out. *)
let has_effect = function
  | _ -> false

(* Remove the second of a pair of reciprocal moves
   i.e. `movq X Y` followed by `movq Y X`.
   Also remove the second `movq` if it's identical to the first. *)
let trim_reciprocal_moves (ins : instr list) : instr list = ins

let optimize (prog : program) : program =
  let (X86Program instrs) = prog in
  let instrs' = instrs |> List.filter has_effect |> trim_reciprocal_moves in
  X86Program instrs'
