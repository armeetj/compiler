open Sexplib
open Sexplib.Conv

module type OrderedTypeS = sig
  include Set.OrderedType

  val sexp_of_t : t -> Sexp.t

  val t_of_sexp : Sexp.t -> t

  val to_string : t -> string
end

module SetS = struct
  module type S = sig
    include Set.S

    val sexp_of_t : t -> Sexp.t

    val t_of_sexp : Sexp.t -> t

    val to_string : t -> string
  end

  module Make (Ord : OrderedTypeS) : S with type elt = Ord.t = struct
    module Wrap = Set.Make (Ord)
    include Wrap

    let sexp_of_t set = Std.sexp_of_list Ord.sexp_of_t (elements set)

    let t_of_sexp sexp = of_list (Std.list_of_sexp Ord.t_of_sexp sexp)

    let to_string set = Utils.pretty_print (sexp_of_t set)
  end
end

module MapS = struct
  module type S = sig
    include Map.S

    val keys : 'a t -> key list

    val of_list : (key * 'a) list -> 'a t

    val sexp_of_t : ('a -> Sexp.t) -> 'a t -> Sexp.t

    val t_of_sexp : (Sexp.t -> 'a) -> Sexp.t -> 'a t

    val to_string : ('a -> Sexp.t) -> 'a t -> string

    val find_or : key -> 'a t -> f:(unit -> 'a) -> 'a

    val find_or_fail : key -> 'a t -> err_msg:string -> 'a
  end

  module Make (Ord : OrderedTypeS) : S with type key = Ord.t = struct
    module Wrap = Map.Make (Ord)
    include Wrap

    let keys map = List.map fst (bindings map)

    let of_list bindings = of_seq (List.to_seq bindings)

    let sexp_of_t sexp_of_a map =
      let sexp_of_binding = sexp_of_pair Ord.sexp_of_t sexp_of_a in
      sexp_of_list sexp_of_binding (bindings map)

    let t_of_sexp a_of_sexp sexp =
      let binding_of_sexp = pair_of_sexp Ord.t_of_sexp a_of_sexp in
      let bindings = list_of_sexp binding_of_sexp sexp in
      of_seq (List.to_seq bindings)

    let to_string sexp_of_a map = Utils.pretty_print (sexp_of_t sexp_of_a map)

    let find_or key map ~f =
      match find_opt key map with
      | None -> f ()
      | Some x -> x

    let find_or_fail key map ~err_msg =
      find_or key map ~f:(fun () -> failwith err_msg)
  end
end
