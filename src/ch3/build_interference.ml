open Types
open X86_var


(* Build the interference graph. *)
let make_graph
      (g : LocUgraph.t) (lbs : (label * binfo2 block) list) : LocUgraph.t =
  failwith "TODO"

(* Replace the Binfo2 field in blocks with a placeholder Binfo1 field. *)
let replace_binfo (lbs : (label * binfo2 block) list)
      : (label * binfo1 block) list =
  List.map
    (fun (lbl, Block (_, instrs)) -> (lbl, Block (Binfo1, instrs)))
    lbs

let build_interference
      (program : (info1, binfo2) program) : (info2, binfo1) program =
  let (X86Program (info1, lbs)) = program in
  let Info1 { locals_types = lts } = info1 in
  let conflicts = make_graph LocUgraph.empty lbs in
  let lbs' = replace_binfo lbs in
  let info2 = Info2 { locals_types = lts; conflicts } in
    X86Program (info2, lbs')

