(* Functional priority queues. *)

open Sexplib
open Functors

(** Priority queue interface. *)
module type PriorityQueue = sig
  type t (* type of priority queue *)

  type elt (* type of priority queue elements *)

  val empty : t
  (** An empty priority queue. *)

  val is_empty : t -> bool
  (** Return `true` if the priority queue is empty. *)

  val insert : elt -> int -> t -> t
  (** Insert an element into the priority queue
        with a specified priority. *)

  val remove_top : t -> elt * t
  (** Remove the top (highest-priority) element.
        Return it and the rest of the queue.
        Raise an error if the priority queue is empty. *)

  val update : elt -> int -> t -> t
  (** Update an element with a new priority.
        Reorder the priority queue to preserve the order invariant.
        Return the updated priority queue.
        If the element is not in the queue, return the queue
        unchanged. *)

  val insert_all : elt list -> int -> t -> t
  (** Insert a list of elements with the same priority.
        Used for move biasing. *)

  val remove_all_top : t -> elt list * int * t
  (** Remove all the top items in the priority queue
        that have the highest priority, along with
        the top priority and the rest of the queue.
        Raise an error if the priority queue is empty.
        Used for move biasing. *)

  val of_list : (elt * int) list -> t
  (** Convert a list of (elem, int) pairs to a priority queue. *)

  val sexp_of_t : t -> Sexp.t
  (** Convert a priority queue to an S-expression. *)

  val t_of_sexp : Sexp.t -> t
  (** Convert an S-expression to a priority queue. *)
end

(** Simple, inefficient implementation of a priority queue. *)
module Simple (Elt : OrderedTypeS) : PriorityQueue with type elt = Elt.t
