(* Undirected immutable graph implementation. *)

open Sexplib
open Sexplib.Conv
open Functors

module type S = sig
  type t

  type elt

  val empty : t

  val is_empty : t -> bool

  val mem : t -> elt -> bool

  val add_vertex : t -> elt -> t

  val remove_vertex : t -> elt -> t

  val add_edge : t -> elt -> elt -> t

  val add_edge_new : t -> elt -> elt -> t

  val neighbors_in : t -> elt -> elt list

  val neighbors_out : t -> elt -> elt list

  val vertices : t -> elt list

  val transpose : t -> t

  val topological_sort : ?start:elt option -> t -> elt list

  val merge_vertices : t -> elt -> elt -> t

  val sexp_of_t : t -> Sexp.t

  val t_of_sexp : Sexp.t -> t

  val to_string : t -> string

  val of_list : (elt * elt) list -> t

  val of_alist : (elt * 'a) list -> ('a -> elt list) -> t
end

module Make (Elt : OrderedTypeS) : S with type elt = Elt.t = struct
  module VMap = MapS.Make (Elt)
  module VSet = SetS.Make (Elt)

  type elt = Elt.t

  type node =
    { in_edges : VSet.t (* vertices with edges to this node *)
    ; out_edges : VSet.t (* vertices from this node to other vertices *) }
  [@@deriving sexp]

  type t = node VMap.t (* map from elt to node *) [@@deriving sexp]

  let to_string g = Utils.pretty_print (sexp_of_t g)

  (* ------------------------------------------------------------------
   * Graph values and functions.
   * ------------------------------------------------------------------ *)

  let empty = VMap.empty

  let is_empty g = VMap.is_empty g

  let mem g e = VMap.mem e g

  let empty_node = {in_edges = VSet.empty; out_edges = VSet.empty}

  let vertex_missing (func_name : string) (e : elt) =
    failwith
    @@ Printf.sprintf "dgraph: %s: vertex %s is not in graph" func_name
         (Elt.to_string e)

  let add_vertex g e =
    if VMap.mem e g then
      failwith
      @@ Printf.sprintf
           "dgraph: add_vertex: vertex %s is already present in graph"
           (Elt.to_string e)
    else VMap.add e empty_node g

  let remove_vertex g e =
    (* Remove in edge from e_in to e. *)
    let remove_in_edge (g : t) (e : elt) (e_in : elt) : t =
      match VMap.find_opt e g with
      | None -> vertex_missing "remove_vertex: remove_in_edge" e
      | Some node ->
        let in_edges' = VSet.remove e_in node.in_edges in
        let node' = {node with in_edges = in_edges'} in
        VMap.add e node' g
    in
    (* Remove out edge from e to e_out. *)
    let remove_out_edge (g : t) (e : elt) (e_out : elt) : t =
      match VMap.find_opt e g with
      | None -> vertex_missing "remove_vertex: remove_out_edge" e
      | Some node ->
        let out_edges' = VSet.remove e_out node.out_edges in
        let node' = {node with out_edges = out_edges'} in
        VMap.add e node' g
    in
    match VMap.find_opt e g with
    | None -> vertex_missing "remove_vertex" e
    | Some {in_edges; out_edges} ->
      (* Remove the vertex itself. *)
      let g' = VMap.remove e g in
      (* Remove the in edges (edges going to the deleted vertex).
       * These are the out edges of the connected vertices. *)
      let g'' =
        List.fold_left
          (fun g e_connected -> remove_out_edge g e_connected e)
          g' (VSet.elements in_edges)
      in
      (* Remove the out edges (edges coming from the deleted vertex).
       * These are the in edges of the connected vertices. *)
      List.fold_left
        (fun g e_connected -> remove_in_edge g e_connected e)
        g'' (VSet.elements out_edges)

  let add_edge g e1 e2 =
    if not (mem g e1) then vertex_missing "add_neighbor" e1
    else if not (mem g e2) then vertex_missing "add_neighbor" e2
    else
      let node_start = VMap.find e1 g in
      let node_end = VMap.find e2 g in
      (* Add `e2` as an out_edge to `e1`'s node (`node_start`). *)
      let node_start' =
        let out_edges' = VSet.add e2 node_start.out_edges in
        {node_start with out_edges = out_edges'}
      in
      (* Add `e1` as an in_edge to `e2`'s node (`node_end`). *)
      let node_end' =
        let in_edges' = VSet.add e1 node_end.in_edges in
        {node_end with in_edges = in_edges'}
      in
      let g' = VMap.add e1 node_start' g in
      VMap.add e2 node_end' g'

  let add_edge_new g e1 e2 =
    match (mem g e1, mem g e2) with
    | true, true -> add_edge g e1 e2
    | true, false ->
      let g' = add_vertex g e2 in
      add_edge g' e1 e2
    | false, true ->
      let g' = add_vertex g e1 in
      add_edge g' e1 e2
    | false, false ->
      let g1 = add_vertex g e1 in
      let g2 = add_vertex g1 e2 in
      add_edge g2 e1 e2

  let neighbors_in g e =
    match VMap.find_opt e g with
    | None -> vertex_missing "neighbors_in" e
    | Some n -> VSet.elements n.in_edges

  let neighbors_out g e =
    match VMap.find_opt e g with
    | None -> vertex_missing "neighbors_out" e
    | Some n -> VSet.elements n.out_edges

  let vertices g = VMap.keys g

  let transpose g =
    (* For each node, swap the in_edges and the out_edges. *)
    let swap_in_out g e =
      let n = VMap.find e g in
      let n' = {in_edges = n.out_edges; out_edges = n.in_edges} in
      VMap.add e n' g
    in
    List.fold_left swap_in_out g (vertices g)

  let topological_sort ?(start : elt option = None) (g : t) : elt list =
    (* Get a list of all vertices that have no incoming edges. *)
    let vertices_no_incoming (g : t) : elt list =
      List.fold_left
        (fun es (e, n) -> if VSet.is_empty n.in_edges then e :: es else es)
        [] (VMap.bindings g)
    in
    (* Pick the "best" vertex with no incoming edges.
     * If there is a designated start vertex,
     * and one which matches the designated start vertex, pick that.
     * Otherwise, pick the lexicographically smallest one.
     * (This is a bit inefficient but it does make it deterministic.) *)
    let best_next_vertex (g : t) : elt option =
      let rec best s (rest : elt list) (e_best : elt) : elt =
        match rest with
        | [] -> e_best
        | e :: es ->
          if Elt.compare s e = 0 then e
          else if Elt.compare e_best e > 0 then best s es e
          else best s es e_best
      in
      match vertices_no_incoming g with
      | [] -> None
      | e :: es -> (
        match start with
        | None -> Some (List.fold_left min e es)
        | Some s -> if Elt.compare s e = 0 then Some e else Some (best s es e) )
    in
    (* Get the best next vertex, remove it (and store it),
     * and continue until all vertices have been removed.
     * Collect the vertices in the order they were removed. *)
    let rec iter g sorted =
      if is_empty g then List.rev sorted
      else
        match best_next_vertex g with
        | None ->
          (* all vertices have incoming edges *)
          failwith "dgraph: topological_sort: no best vertex (not a DAG)"
        | Some e ->
          let g' = remove_vertex g e in
          iter g' (e :: sorted)
    in
    if is_empty g then failwith "dgraph: topological_sort: no graph to sort!"
    else iter g []

  let merge_vertices g e1 e2 =
    match (VMap.find_opt e1 g, VMap.find_opt e2 g) with
    | None, _ -> vertex_missing "merge_vertices" e1
    | _, None -> vertex_missing "merge_vertices" e2
    | Some e1_node, Some e2_node ->
      let label = "dgraph: merge_vertices" in
      let e1_outs = e1_node.out_edges in
      let e2_ins = e2_node.in_edges in
      (* Check that e1 has only one out edge, to e2. *)
      if VSet.cardinal e1_outs <> 1 || not (VSet.mem e2 e1_outs) then
        failwith
        @@ Printf.sprintf "%s: first vertex (%s) cannot be merged" label
             (Elt.to_string e1)
        (* Check that e2 has only one in edge, from e1. *)
      else if VSet.cardinal e2_ins <> 1 || not (VSet.mem e1 e2_ins) then
        failwith
        @@ Printf.sprintf "%s: second vertex (%s) cannot be merged" label
             (Elt.to_string e2)
      else
        (* OK to merge. Create the new vertex. *)
        let out_edges = e2_node.out_edges in
        let v_node = {e1_node with out_edges} in
        (* Remove `e2` and all its connections from the graph. *)
        let g1 = remove_vertex g e2 in
        (* Add `v` as the new `e1`.
         * It has the in edges of the old `e1`
         * and the out edges of `e2`. *)
        let g2 = VMap.add e1 v_node g1 in
        (* Add the out edges from `e1` to the in edges of the targets. *)
        List.fold_left
          (fun g e_target ->
            match VMap.find_opt e_target g with
            | None ->
              failwith
              @@ Printf.sprintf "%s: expected target node (%s) not found" label
                   (Elt.to_string e_target)
            | Some target_node ->
              (* Add an in edge from `e1` to the target node.
               * Recall that before removing the `e2` vertex,
               * it used to have an in edge from `e2`. *)
              let target_ins = target_node.in_edges in
              let in_edges = VSet.add e1 target_ins in
              let target_node' = {target_node with in_edges} in
              VMap.add e_target target_node' g )
          g2 (VSet.elements out_edges)

  let of_list lst =
    List.fold_left (fun g (x, y) -> add_edge_new g x y) empty lst

  let of_alist alist get_elts =
    alist
    |> List.concat_map (fun (e, x) ->
         get_elts x |> List.map (fun e' -> (e, e')) )
    |> of_list
end
