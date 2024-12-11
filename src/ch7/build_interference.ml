open Support.Utils
open Sexplib
open Types
open X86_var_def


(* Build the interference graph.
   `vvs` are the vector-valued variables. *)
let make_graph
      (g : LocUgraph.t) (lbs : (label * binfo2 block) list) (vvs : VarSet.t)
         : LocUgraph.t =
  failwith "TODO"

(* Replace the Binfo2 field in blocks with a placeholder Binfo1 field. *)
let replace_binfo (lbs : (label * binfo2 block) list)
      : (label * binfo1 block) list =
  List.map
    (fun (lbl, Block (_, instrs)) -> (lbl, Block (Binfo1, instrs)))
    lbs

(* Add extra edges between locals that aren't in the interference graph
   and the %rsp register. This is needed because there are cases
   (e.g. with TailJmp and IndirectCallq) where variables
   would otherwise disappear from the interference graph.
   This would create problems in the "allocate registers" pass.
   *)
let add_extra_rsp_edges (g : LocUgraph.t) (vs : VarSet.t) : LocUgraph.t =
  failwith "TODO"

(* Collect the vector-typed vars. *)
let vector_vars (lts : (var * ty) list) : VarSet.t =
  let is_vector = function
    | Vector _ -> true
    | _ -> false
  in
    lts
     |> List.filter_map (fun (v, t) -> if is_vector t then Some v else None)
     |> VarSet.of_list

let build_interference_def
      (def : (finfo1, binfo2) def) : (finfo2, binfo1) def =
  (* Unpack the labeled block list (`lbs`) from a definition. *)
  let (Def (lbl, _, fcont)) = def in
  let { nparams; locals; body = lbs } = fcont in

  (* Compute the interference graph. *)
  let vvs = vector_vars locals in
  let conflicts_init = make_graph LocUgraph.empty lbs vvs in

  (* Patch the interference graph by adding %rsp edges
     to any variables which aren't in the graph. *)
  let locals_set = VarSet.of_list (List.map fst locals) in
  let conflicts = add_extra_rsp_edges conflicts_init locals_set in

  (* Put the definition back together. *)
  let lbs' = replace_binfo lbs in
  let finfo = Finfo2 { conflicts } in
  let fcont' = { nparams; locals; body = lbs' } in
    Def (lbl, finfo, fcont')

let build_interference
    (prog : (finfo1, binfo2) program) : (finfo2, binfo1) program =
  let (X86Program defs) = prog in
    X86Program (List.map build_interference_def defs)

