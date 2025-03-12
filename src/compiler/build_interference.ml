open Types
open X86_var_def

(*
adds undirected edge for every pair u, v,
where u is from lst1 and v is from lst2
*)
let add_edges lst1 lst2 g =
  List.fold_left
    (fun acc u ->
      List.fold_left
        (fun acc v ->
          (* edge case of rax <-> rax edge *)
          if OrderedLoc.compare u v <> 0 then LocUgraph.add_edge_new acc u v
          else acc )
        acc lst2 )
    g lst1

let location_of arg =
  match arg with
  | Reg r -> RegL r
  | ByteReg b -> RegL (reg_of_bytereg b)
  | Var v -> VarL v
  | Deref (r, _) -> RegL r
  | _ -> failwith "shouldn't reach"

let write instr =
  match instr with
  | Addq (_, GlobalArg _) -> []
  | Subq (_, GlobalArg _) -> []
  | Leaq (_, arg2) -> [location_of arg2]
  | Movq (_, arg2) -> [location_of arg2]
  | Movzbq (_, arg2) -> [location_of arg2]
  | Addq (_, arg2) -> [location_of arg2]
  | Subq (_, arg2) -> [location_of arg2]
  | Andq (_, arg2) -> [location_of arg2]
  | Sarq (_, arg2) -> [location_of arg2]
  | Negq arg -> [location_of arg]
  | Xorq (_, arg2) -> [location_of arg2]
  | Cmpq _ -> [RegL Rflags]
  | Set (_, arg) -> [location_of arg]
  | Pushq _ -> [RegL Rsp]
  | Popq arg -> [location_of arg]
  | Callq (Label "collect", _)
   |IndirectCallq (_, _) ->
    List.map (fun reg -> RegL reg) (RegSet.elements caller_save_regs)
  | Callq (_, _) ->
    List.map (fun reg -> RegL reg) (RegSet.elements caller_save_regs)
  | _ -> []

(* removing vertices that shouldn't be connected *)
let remove_eq instr st =
  match instr with
  | Movq (Imm _, arg2) -> (
    match arg2 with
    | GlobalArg _ -> st
    | _ -> LocSet.remove (location_of arg2) st )
  | Movq (arg1, arg2) -> (
    match (arg1, arg2) with
    | GlobalArg _, GlobalArg _ -> st
    | GlobalArg _, _ -> LocSet.remove (location_of arg2) st
    | _, GlobalArg _ -> LocSet.remove (location_of arg1) st
    | _ ->
      LocSet.remove (location_of arg1) (LocSet.remove (location_of arg2) st) )
  | Callq _ -> st
  | instr ->
    let rec iter_remove lst st =
      match lst with
      | [] -> st
      | h :: t -> LocSet.remove h (iter_remove t st)
    in
    iter_remove (write instr) st

(* Build the interference graph.
   `vvs` are the vector-valued variables. *)
let make_graph (g : LocUgraph.t) (lbs : (label * binfo2 block) list)
  (vvs : VarSet.t) : LocUgraph.t =
  let rec helper acc lb =
    (* acc is essentially g, for our purposes *)
    let lbl, Block (Binfo2 {afters; _}, instrs) = lb in
    match (instrs, afters) with
    | [], [] -> acc
    | i :: t_i, a :: t_a ->
      let new_block =
        Block (Binfo2 {initial = LocSet.empty; afters = t_a}, t_i)
      in
      let acc =
        match i with
        | Callq (Label "collect", _) ->
          add_edges
            (List.map (fun reg -> RegL reg) (RegSet.elements callee_save_regs))
            (LocSet.elements
               (LocSet.filter
                  (function
                    | VarL v -> VarSet.mem v vvs
                    | _ -> false )
                  a ) )
            acc
        | IndirectCallq (_, _) ->
          let caller_saved =
            List.map (fun reg -> RegL reg) (RegSet.elements caller_save_regs)
          in
          let callee_saved =
            List.map (fun reg -> RegL reg) (RegSet.elements callee_save_regs)
          in
          let vector_vars =
            LocSet.elements
              (LocSet.filter
                 (function
                   | VarL v -> VarSet.mem v vvs
                   | _ -> false )
                 a )
          in
          let acc = add_edges caller_saved (LocSet.elements a) acc in
          add_edges callee_saved vector_vars acc
        | _ -> acc
      in
      add_edges (write i)
        (LocSet.elements (remove_eq i a))
        (helper acc (lbl, new_block))
    | _ -> failwith "instrs and afters should have same size"
  in
  List.fold_left helper g lbs (* Getting each block and populating g *)

(* Replace the Binfo2 field in blocks with a placeholder Binfo1 field. *)
let replace_binfo (lbs : (label * binfo2 block) list) :
  (label * binfo1 block) list =
  List.map (fun (lbl, Block (_, instrs)) -> (lbl, Block (Binfo1, instrs))) lbs

(* Add extra edges between locals that aren't in the interference graph
   and the %rsp register. This is needed because there are cases
   (e.g. with TailJmp and IndirectCallq) where variables
   would otherwise disappear from the interference graph.
   This would create problems in the "allocate registers" pass.
*)
let add_extra_rsp_edges (g : LocUgraph.t) (vs : VarSet.t) : LocUgraph.t =
  let ensure_vertex g vertex =
    if not (LocUgraph.mem g vertex) then LocUgraph.add_vertex g vertex else g
  in
  VarSet.fold
    (fun v graph ->
      let var_vertex = VarL v in
      let rsp_vertex = RegL Rsp in
      if LocUgraph.mem graph var_vertex then graph
      else
        graph
        |> (fun g -> ensure_vertex g var_vertex)
        |> (fun g -> ensure_vertex g rsp_vertex)
        |> fun g -> LocUgraph.add_edge g rsp_vertex var_vertex )
    vs g

let vector_vars (lts : (var * ty) list) : VarSet.t =
  let is_vector = function
    | Vector _ -> true
    | _ -> false
  in
  lts
  |> List.filter_map (fun (v, t) -> if is_vector t then Some v else None)
  |> VarSet.of_list

let build_interference_def (def : (finfo1, binfo2) def) : (finfo2, binfo1) def =
  (* Unpack the labeled block list (`lbs`) from a definition. *)
  let (Def (lbl, _, fcont)) = def in
  let {nparams; locals; body = lbs} = fcont in
  (* Compute the interference graph. *)
  let vvs = vector_vars locals in
  let conflicts_init = make_graph LocUgraph.empty lbs vvs in
  (* Patch the interference graph by adding %rsp edges
     to any variables which aren't in the graph. *)
  let locals_set = VarSet.of_list (List.map fst locals) in
  let conflicts = add_extra_rsp_edges conflicts_init locals_set in
  (* Put the definition back together. *)
  let lbs' = replace_binfo lbs in
  let finfo = Finfo2 {conflicts} in
  let fcont' = {nparams; locals; body = lbs'} in
  Def (lbl, finfo, fcont')

let build_interference (prog : (finfo1, binfo2) program) :
  (finfo2, binfo1) program =
  let (X86Program defs) = prog in
  X86Program (List.map build_interference_def defs)
