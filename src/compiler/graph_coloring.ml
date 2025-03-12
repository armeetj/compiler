open Sexplib.Std
open Support
open Functors
open Types
open Priority_queue

(* Use this to turn debugging code on or off. *)
let _debug_gc = ref false

module type GraphColor = sig
  type elt

  type graph

  type pqueue

  type 'a eltmap

  val color : graph -> int eltmap -> int eltmap
end

module Make
    (Elt : OrderedTypeS)
    (EMap : MapS.S with type key = Elt.t)
    (PQ : PriorityQueue with type elt = Elt.t)
    (Graph : Ugraph.S with type elt = Elt.t) :
  GraphColor
    with type elt = Elt.t
     and type 'a eltmap = 'a EMap.t
     and type pqueue = PQ.t
     and type graph = Graph.t = struct
  type elt = Elt.t

  type 'a eltmap = 'a EMap.t [@@deriving sexp]

  type graph = Graph.t

  type pqueue = PQ.t

  (* Where node information is stored. *)
  type node = {color : int option; saturation : IntSet.t} [@@deriving sexp]

  (* Map between graph elements and nodes.
   * This is what gets updated as the algorithm unfolds. *)
  type nodemap = node eltmap [@@deriving sexp]

  (* ------------------------------------------------------------ *)

  (* Debugging. *)

  let _print_nodemap msg (map : nodemap) : unit =
    Printf.printf "\n%s:\n%s\n\n%!" msg
      (Utils.pretty_print (sexp_of_nodemap map))

  let _string_of_elt (e : elt) : string =
    Elt.sexp_of_t e |> Sexplib.Sexp.to_string

  (* ------------------------------------------------------------ *)

  (* Return `true` if an element's node in a nodemap is uncolored. *)
  let is_uncolored (e : elt) (map : nodemap) : bool =
    match EMap.find_opt e map with
    | Some {color = Some _; saturation = _} -> false
    | _ -> true

  (* Starting from an initial partial mapping
   * between graph elements and colors (the precolored map),
   * compute an initial nodemap.
   * Also compute the initial saturation sets for all nodes.
   *)
  let initial_nodemap (g : graph) (precolored_map : int eltmap) : nodemap =
    let get_saturation elt =
      let neighbors = Graph.neighbors g elt in
      List.fold_left
        (fun acc elt ->
          match EMap.find_opt elt precolored_map with
          | Some c -> IntSet.add c acc
          | None -> acc )
        IntSet.empty neighbors
    in
    let handle_node nmap elt =
      let c = EMap.find_opt elt precolored_map in
      let s = get_saturation elt in
      EMap.add elt {color = c; saturation = s} nmap
    in
    List.fold_left handle_node EMap.empty (Graph.vertices g)

  (* Initialize the priority queue with uncolored nodes only. *)
  let initial_priority_queue (map : nodemap) : pqueue =
    (* Priority queue elements are (elt, int) pairs,
     * where the int is the priority. *)
    let handle_node elt node q =
      match node with
      | {color = Some _; saturation = _} -> q
      | {color = None; saturation = s} -> PQ.insert elt (IntSet.cardinal s) q
    in
    EMap.fold handle_node map PQ.empty

  (* Pick the smallest non-negative integer not in the set. *)
  let pick_color (set : IntSet.t) : int =
    let rec f color =
      match IntSet.mem color set with
      | true -> f (color + 1)
      | false -> color
    in
    f 0

  (* Add a color to:
   * a) an element's node
   * b) the element's neighbors' saturation maps
   * Also, every time a saturation map increases in size,
   * adjust the element's position in the priority queue.
   *)
  let add_color (g : graph) (e : elt) (c : int) (map : node eltmap) (pq : PQ.t)
    : node eltmap * PQ.t =
    (* a - add color to e *)
    let node = EMap.find e map in
    let new_node = {color = Some c; saturation = node.saturation} in
    let map = EMap.add e new_node map in
    (* b - add color to all neighbor saturation maps *)
    let handle_neighbor (map, pq) e =
      (* update map first *)
      let old_node = EMap.find e map in
      let new_node =
        {color = old_node.color; saturation = IntSet.add c old_node.saturation}
      in
      let new_map = EMap.add e new_node map in
      (* then update in pq *)
      let new_pq = PQ.update e (IntSet.cardinal new_node.saturation) pq in
      (new_map, new_pq)
    in
    List.fold_left handle_neighbor (map, pq) (Graph.neighbors g e)

  (* Generate the final int eltmap from the final node eltmap. *)
  let make_final_color_map (map : node eltmap) : int eltmap =
    let handle_node e node imap =
      match node with
      | {color = Some c; saturation = _} -> EMap.add e c imap
      | {color = None; saturation = _} ->
        failwith "node doesn't have color! something went wrong in alg"
    in
    EMap.fold handle_node map EMap.empty

  let color (g : graph) (precolored_map : int eltmap) : int eltmap =
    (* Algorithm:
     * - find the uncolored location with the highest priority
     * - remove it from the queue
     * - pick a color for it based on its neighbor colors
     *   (the saturation set)
     * - add the color to all the neighbors' saturation sets
     *   (updating their places in the priority queue)
     * - continue until the queue is empty
     *)
    let init_map = initial_nodemap g precolored_map in
    let init_pq = initial_priority_queue init_map in
    let rec iter (map : node eltmap) (pq : PQ.t) : node eltmap =
      if PQ.is_empty pq then map (* all colors assigned *)
      else
        let e, pq' = PQ.remove_top pq in
        if not (is_uncolored e map) then
          failwith "color: colored nodes are not allowed in priority queue"
        else
          let node =
            EMap.find_or_fail e map ~err_msg:"color: element not in map!"
          in
          let color = pick_color node.saturation in
          let map', pq'' = add_color g e color map pq' in
          iter map' pq''
    in
    make_final_color_map (iter init_map init_pq)
end
