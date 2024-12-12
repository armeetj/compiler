open Types
open X86_var_global

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
  | Callq _ -> List.map (fun reg -> RegL reg) (RegSet.elements caller_save_regs)
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

(* Build the interference graph. *)
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

(* Collect the vector-typed vars. *)
let vector_vars (lts : (var * ty) list) : VarSet.t =
  let is_vector = function
    | Vector _ -> true
    | _ -> false
  in
  lts
  |> List.filter_map (fun (v, t) -> if is_vector t then Some v else None)
  |> VarSet.of_list

let build_interference (program : (info1, binfo2) program) :
  (info2, binfo1) program =
  let (X86Program (info1, lbs)) = program in
  let (Info1 {locals_types = lts}) = info1 in
  let vvs = vector_vars lts in
  let conflicts = make_graph LocUgraph.empty lbs vvs in
  let lbs' = replace_binfo lbs in
  let info2 = Info2 {locals_types = lts; conflicts} in
  X86Program (info2, lbs')
