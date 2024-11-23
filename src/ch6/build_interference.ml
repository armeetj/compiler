open Support.Utils
open Sexplib
open Types
open X86_var_global

(* Build the interference graph.
   `vvs` are the vector-valued variables. *)
let make_graph (g : LocUgraph.t) (lbs : (label * binfo2 block) list)
    (vvs : VarSet.t) : LocUgraph.t =
  failwith "TODO"

(* Replace the Binfo2 field in blocks with a placeholder Binfo1 field. *)
let replace_binfo (lbs : (label * binfo2 block) list) :
    (label * binfo1 block) list =
  List.map (fun (lbl, Block (_, instrs)) -> (lbl, Block (Binfo1, instrs))) lbs

(* Collect the vector-typed vars. *)
let vector_vars (lts : (var * ty) list) : VarSet.t =
  let is_vector = function Vector _ -> true | _ -> false in
  lts
  |> List.filter_map (fun (v, t) -> if is_vector t then Some v else None)
  |> VarSet.of_list

let build_interference (program : (info1, binfo2) program) :
    (info2, binfo1) program =
  let (X86Program (info1, lbs)) = program in
  let (Info1 { locals_types = lts }) = info1 in
  let vvs = vector_vars lts in
  let conflicts = make_graph LocUgraph.empty lbs vvs in
  let lbs' = replace_binfo lbs in
  let info2 = Info2 { locals_types = lts; conflicts } in
  X86Program (info2, lbs')
