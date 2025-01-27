(* ch5 *)
open Types
open Cloop

let rec find_reachable l tm vis =
  if LabelSet.mem l vis then vis
  else if LabelMap.mem l tm then
    let tail = LabelMap.find l tm in
    let jump_labels = get_jump_labels tail in
    find_reachable_list jump_labels tm (LabelSet.add l vis)
  else LabelSet.add l vis

and find_reachable_list labels tm vis =
  match labels with
  | [] -> vis
  | l :: x -> find_reachable_list x tm (find_reachable l tm vis)

let rec tm_of_l lts =
  match lts with
  | [] -> LabelMap.empty
  | (l, t) :: rest -> LabelMap.add l t (tm_of_l rest)

let process_blocks (lts : (label * tail) list) : (label * tail) list =
  let reachable = find_reachable (Label "start") (tm_of_l lts) LabelSet.empty in
  lts
  |> List.filter (fun (l, _) -> LabelSet.mem l reachable)
  |> List.sort compare

let remove_unused_blocks (prog : program) : program =
  let (CProgram (info, lts)) = prog in
  CProgram (info, process_blocks lts)
