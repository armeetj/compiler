(* Undirected immutable graph implementation. *)

open Sexplib
open Functors

module type S = sig
  type t

  type elt

  val empty : t

  val is_empty : t -> bool

  val mem : t -> elt -> bool

  val add_vertex : t -> elt -> t

  val add_edge : t -> elt -> elt -> t

  val add_edge_new : t -> elt -> elt -> t

  val neighbors : t -> elt -> elt list

  val neighbors_or_none : t -> elt -> elt list

  val vertices : t -> elt list

  val sexp_of_t : t -> Sexp.t

  val t_of_sexp : Sexp.t -> t

  val to_string : t -> string

  val of_list : (elt * elt) list -> t

  val to_list : t -> (elt * elt list) list
end

module Make (Elt : OrderedTypeS) : S with type elt = Elt.t = struct
  module VSet = SetS.Make (Elt)
  module VMap = MapS.Make (Elt)

  type elt = Elt.t

  type node = VSet.t (* set of neighbors *) [@@deriving sexp]

  type t = node VMap.t (* map from elt to node *) [@@deriving sexp]

  let to_string g = Utils.pretty_print (sexp_of_t g)

  (* ------------------------------------------------------------------
   * Graph values and functions.
   * ------------------------------------------------------------------ *)

  let empty = VMap.empty

  let is_empty g = VMap.is_empty g

  let mem g e = VMap.mem e g

  let add_vertex g e =
    if VMap.mem e g then
      failwith
      @@ Printf.sprintf
           "ugraph: add_vertex: vertex %s is already present in graph"
           (Elt.to_string e)
    else VMap.add e VSet.empty g

  (* Add a directed edge from element e1 to element e2. *)
  let add_neighbor g e1 e2 =
    if not (mem g e1) then
      failwith
      @@ Printf.sprintf
           "ugraph: add_neighbor: vertex 1 (%s) of edge is not in graph"
           (Elt.to_string e1)
    else if not (mem g e2) then
      failwith
      @@ Printf.sprintf
           "ugraph: add_neighbor: vertex 2 (%s) of edge is not in graph"
           (Elt.to_string e2)
    else
      let nodes = VMap.find e1 g in
      let nodes' = VSet.add e2 nodes in
      VMap.add e1 nodes' g

  let add_edge g e1 e2 =
    let g' = add_neighbor g e1 e2 in
    add_neighbor g' e2 e1

  let add_edge_new g e1 e2 =
    match (mem g e1, mem g e2) with
    | true, true ->
        add_edge g e1 e2
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

  let neighbors g e =
    match VMap.find_opt e g with
    | None ->
        failwith
        @@ Printf.sprintf "ugraph: neighbors: element %s not in graph"
             (Elt.to_string e)
    | Some ns ->
        VSet.elements ns

  let neighbors_or_none g e =
    match VMap.find_opt e g with None -> [] | Some ns -> VSet.elements ns

  let bindings g = VMap.bindings g

  let vertices g = List.map fst (bindings g)

  let of_list lst =
    List.fold_left (fun g (x, y) -> add_edge_new g x y) empty lst

  let to_list g = List.map (fun (e, s) -> (e, VSet.elements s)) (bindings g)
end
