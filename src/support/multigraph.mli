(* Directed immutable multigraphs. *)

open Sexplib
open Functors

module type S = sig
  type t (* type of graph *)

  type elt (* type of vertices *)

  val empty : t
  (** Make a new, empty graph. *)

  val is_empty : t -> bool
  (** return `true` if the graph is empty. *)

  val mem : t -> elt -> bool
  (** Return `true` if the element is a vertex in the graph. *)

  val add_vertex : t -> elt -> t
  (** Add a new, empty vertex to the graph.
        An error is signalled if the vertex is already in the graph. *)

  val remove_vertex : t -> elt -> t
  (** Remove a vertex and all its edges from the graph.
        An error is signalled if the vertex is not in the graph. *)

  val add_edge : t -> elt -> elt -> t
  (** Add a directed edge between two different vertices of the graph.
        An error is signalled if either vertex is not in the graph. *)

  val add_edge_new : t -> elt -> elt -> t
  (** Add a directed edge between two different vertices of the graph.
        If either vertex is not in the graph, it is created. *)

  val neighbors_in : t -> elt -> elt list
  (** Return a list of all neighbors which have edges
        going to a particular vertex.
        Raise a `Failure` exception if the vertex is not in the graph. *)

  val neighbors_out : t -> elt -> elt list
  (** Return a list of all neighbors which a vertex has edges to.
        Raise a `Failure` exception if the vertex is not in the graph. *)

  val vertices : t -> elt list
  (** Return a list of all the vertices in the graph. *)

  val transpose : t -> t
  (** Return the transpose of this graph. *)

  val topological_sort : ?start:elt option -> t -> elt list
  (** Return a list of vertices in topologically sorted order.
        `start` is the optional starting vertex.
        An error is signalled if the vertices can't be
        topologically sorted (because the graph is not a DAG). *)

  val sexp_of_t : t -> Sexp.t
  (** Convert a graph to an S-expression. *)

  val t_of_sexp : Sexp.t -> t
  (** Convert an S-expression to a graph. *)

  val to_string : t -> string
  (** Convert a graph to a string. *)

  val of_list : (elt * elt) list -> t
  (** Convert a list of edges to a graph. *)

  val of_alist : (elt * 'a) list -> ('a -> elt list) -> t
  (** Convert a list of (elt, x) to a graph. *)
end

module Make (Elt : OrderedTypeS) : S with type elt = Elt.t
