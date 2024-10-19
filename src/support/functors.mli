(** Various useful functors. *)

open Sexplib

(** An extension of `OrderedType` which also does sexp conversions. *)
module type OrderedTypeS = sig
  include Set.OrderedType

  val sexp_of_t : t -> Sexp.t
  (** Convert a value to an S-expression. *)

  val t_of_sexp : Sexp.t -> t
  (** Convert an S-expression to a value. *)

  val to_string : t -> string
  (** Convert a value to a string. *)
end

(** An extension of `Set` which also does sexp conversions. *)
module SetS : sig
  module type S = sig
    include Set.S

    val sexp_of_t : t -> Sexp.t
    (** Convert a set to an S-expression. *)

    val t_of_sexp : Sexp.t -> t
    (** Convert an S-expression to a set. *)

    val to_string : t -> string
    (** Convert a set to a string. *)
  end

  module Make (Ord : OrderedTypeS) : S with type elt = Ord.t
end

(** An extension of `Map` which also does sexp conversions. *)
module MapS : sig
  module type S = sig
    include Map.S

    val keys : 'a t -> key list
    (** Return all the keys of the map. *)

    val of_list : (key * 'a) list -> 'a t
    (** Convert a (key, value) list to a map. *)

    val sexp_of_t : ('a -> Sexp.t) -> 'a t -> Sexp.t
    (** Convert a map to an S-expression. *)

    val t_of_sexp : (Sexp.t -> 'a) -> Sexp.t -> 'a t
    (** Convert an S-expression to a map. *)

    val to_string : ('a -> Sexp.t) -> 'a t -> string
    (** Convert a map to a string. *)

    val find_or : key -> 'a t -> f:(unit -> 'a) -> 'a
    (** Find a key in a map, or else execute an error function. *)

    val find_or_fail : key -> 'a t -> err_msg:string -> 'a
    (** Find a key in a map, or else raise a `Failure`
            exception with the given error message. *)
  end

  module Make (Ord : OrderedTypeS) : S with type key = Ord.t
end
