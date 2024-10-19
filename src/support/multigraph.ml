(* Undirected immutable multigraph implementation. *)

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
  val sexp_of_t : t -> Sexp.t
  val t_of_sexp : Sexp.t -> t
  val to_string : t -> string
  val of_list : (elt * elt) list -> t
  val of_alist : (elt * 'a) list -> ('a -> elt list) -> t
end

module Make (Elt : OrderedTypeS) : S with type elt = Elt.t = struct
  module VMap = MapS.Make (Elt)

  type elt = Elt.t

  (* We use int maps instead of sets because we can have multiple
   * edges between the same vertices.  The int is the count of edges
   * between the two vertices. *)
  type node = {
    in_edges : int VMap.t; (* vertices with edges to this node *)
    out_edges : int VMap.t (* vertices from this node to other vertices *);
  }
  [@@deriving sexp]

  type t = node VMap.t (* map from elt to node *) [@@deriving sexp]

  let to_string g = Utils.pretty_print (sexp_of_t g)

  (* ------------------------------------------------------------------
   * Graph values and functions.
   * ------------------------------------------------------------------ *)

  let empty = VMap.empty
  let is_empty g = VMap.is_empty g
  let mem g e = VMap.mem e g
  let empty_node = { in_edges = VMap.empty; out_edges = VMap.empty }

  let vertex_missing (func_name : string) (e : elt) =
    failwith
    @@ Printf.sprintf "multigraph: %s: vertex %s is not in graph" func_name
         (Elt.to_string e)

  (* Add an edge to one of the `[in,out]_edges` maps,
   * which means incrementing the edge count by 1 if it's present,
   * or assigning it to 1 if it isn't. *)
  let incr_edge_count (e : elt) (map : int VMap.t) : int VMap.t =
    VMap.update e (function None -> Some 1 | Some n -> Some (n + 1)) map

  let add_vertex g e =
    if VMap.mem e g then
      failwith
      @@ Printf.sprintf
           "multigraph: add_vertex: vertex %s is already present in graph"
           (Elt.to_string e)
    else VMap.add e empty_node g

  let remove_vertex g e =
    (* Remove in edges from e_in to e. *)
    let remove_in_edges (g : t) (e : elt) (e_in : elt) : t =
      match VMap.find_opt e g with
      | None -> vertex_missing "remove_vertex: remove_in_edges" e
      | Some node ->
          let in_edges' = VMap.remove e_in node.in_edges in
          let node' = { node with in_edges = in_edges' } in
          VMap.add e node' g
    in

    (* Remove out edges from e to e_out. *)
    let remove_out_edges (g : t) (e : elt) (e_out : elt) : t =
      match VMap.find_opt e g with
      | None -> vertex_missing "remove_vertex: remove_out_edges" e
      | Some node ->
          let out_edges' = VMap.remove e_out node.out_edges in
          let node' = { node with out_edges = out_edges' } in
          VMap.add e node' g
    in

    match VMap.find_opt e g with
    | None -> vertex_missing "remove_vertex" e
    | Some { in_edges; out_edges } ->
        (* Remove the vertex itself. *)
        let g' = VMap.remove e g in
        (* Remove the in edges (edges going to the deleted vertex).
         * These are the out edges of the connected vertices. *)
        let g'' =
          List.fold_left
            (fun g e_connected -> remove_out_edges g e_connected e)
            g' (VMap.keys in_edges)
        in
        (* Remove the out edges (edges coming from the deleted vertex).
         * These are the in edges of the connected vertices. *)
        List.fold_left
          (fun g e_connected -> remove_in_edges g e_connected e)
          g'' (VMap.keys out_edges)

  let add_edge g e1 e2 =
    if not (mem g e1) then vertex_missing "add_neighbor" e1
    else if not (mem g e2) then vertex_missing "add_neighbor" e2
    else
      let node_start = VMap.find e1 g in
      let node_end = VMap.find e2 g in
      (* Add `e2` as an out_edge to `e1`'s node (`node_start`). *)
      let node_start' =
        let out_edges' = incr_edge_count e2 node_start.out_edges in
        { node_start with out_edges = out_edges' }
      in
      (* Add `e1` as an in_edge to `e2`'s node (`node_end`). *)
      let node_end' =
        let in_edges' = incr_edge_count e1 node_end.in_edges in
        { node_end with in_edges = in_edges' }
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
    | Some n -> VMap.keys n.in_edges

  let neighbors_out g e =
    match VMap.find_opt e g with
    | None -> vertex_missing "neighbors_out" e
    | Some n -> VMap.keys n.out_edges

  let vertices g = VMap.keys g

  let transpose g =
    (* For each node, swap the in_edges and the out_edges. *)
    let swap_in_out g e =
      let n = VMap.find e g in
      let n' = { in_edges = n.out_edges; out_edges = n.in_edges } in
      VMap.add e n' g
    in
    List.fold_left swap_in_out g (vertices g)

  let topological_sort ?(start : elt option = None) (g : t) : elt list =
    (* Get a list of all vertices that have no incoming edges. *)
    let vertices_no_incoming (g : t) : elt list =
      List.fold_left
        (fun es (e, n) -> if VMap.is_empty n.in_edges then e :: es else es)
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
          | Some s -> if Elt.compare s e = 0 then Some e else Some (best s es e)
          )
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
            failwith "multigraph: topological_sort: no best vertex (not a DAG)"
        | Some e ->
            let g' = remove_vertex g e in
            iter g' (e :: sorted)
    in

    if is_empty g then
      failwith "multigraph: topological_sort: no graph to sort!"
    else iter g []

  let of_list lst =
    List.fold_left (fun g (x, y) -> add_edge_new g x y) empty lst

  let of_alist alist get_elts =
    alist
    |> List.concat_map (fun (e, x) ->
           get_elts x |> List.map (fun e' -> (e, e')))
    |> of_list
end
