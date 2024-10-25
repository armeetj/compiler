open Types
open X86_var


(* 
adds undirected edge for every pair u, v, 
where u is from lst1 and v is from lst2 
*)
let add_edges lst1 lst2 g =
  List.fold_left (fun acc u ->
    List.fold_left (fun acc v ->
      (* edge case of rax <-> rax edge *)
      if OrderedLoc.compare u v <> 0 then LocUgraph.add_edge_new acc u v
      else acc
    ) acc lst2
  ) g lst1

let location_of arg =
  match arg with 
  | Reg r -> RegL r
  | Var v -> VarL v
  | _ -> failwith "shouldn't reach"

(* returns location list, representing W(I) 
- TODO: Check if functionality of sub, neg, push, and pop are correct.
  Addq was necessary for 2 tests, but the others weren't, but still added. 
*)
let write instr = 
  match instr with
  | Movq (_, arg2) -> [location_of arg2]
  | Addq (_, arg2) -> [location_of arg2]
  | Subq (_, arg2) -> [location_of arg2]
  | Negq arg -> [location_of arg]
  | Pushq _ -> [RegL Rsp]
  | Popq arg -> [location_of arg]  
  | Callq _ -> List.map (fun reg -> RegL reg) (RegSet.elements caller_save_regs)
  | _ -> []

(* removing vertices that shouldn't be connected *)
let remove_eq instr st = 
  match instr with
  | Movq (Imm _, arg2) ->
    LocSet.remove (location_of arg2) st
  | Movq (arg1, arg2) -> LocSet.remove (location_of arg1) (LocSet.remove (location_of arg2) st)
  | Callq _ -> st
  | instr -> 
    let rec iter_remove lst st = 
      match lst with 
      | [] -> st
      | h :: t -> LocSet.remove h (iter_remove t st)
    in iter_remove (write instr) st

(* Build the interference graph. *)
let make_graph (g : LocUgraph.t) (lbs : (label * binfo2 block) list) : LocUgraph.t =
  let rec helper acc lb = (* acc is essentially g, for our purposes *)
    let (lbl, Block (Binfo2 {afters; _ }, instrs)) = lb in 
    match instrs, afters with
    | [], [] -> acc
    | i::t_i, a::t_a -> 
      let new_block = Block (Binfo2 { initial = LocSet.empty; afters = t_a }, t_i)
      in add_edges (write i) (LocSet.to_list (remove_eq i a)) (helper acc (lbl, new_block))
    | _ -> failwith "instrs and afters should have same size"
  in List.fold_left helper g lbs (* Getting each block and populating g *)

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

