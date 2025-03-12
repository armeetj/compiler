(** Graph coloring algorithm. *)

open Support
open Functors
open Priority_queue

module type GraphColor = sig
  (** Type of graph elements. *)
  type elt

  (** Type of element -> 'a map. *)
  type 'a eltmap

  (** Type of priority queue. *)
  type pqueue

  (** Type of the graph. *)
  type graph

  val color : graph -> int eltmap -> int eltmap
  (** Compute a graph coloring.
        Colors are represented by integers.
        Arguments:
        - an interference graph
        - a precolored node map; this is a map
          between graph elements and colors for elements
          which have colors before the algorithm begins
        Return value:
        - a complete mapping of graph elements to colors *)
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
     and type graph = Graph.t
