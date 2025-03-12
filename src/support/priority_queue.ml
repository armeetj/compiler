open Sexplib
open Sexplib.Conv
open Functors

module type PriorityQueue = sig
  type t

  type elt

  val empty : t

  val is_empty : t -> bool

  val insert : elt -> int -> t -> t

  val remove_top : t -> elt * t

  val update : elt -> int -> t -> t

  val insert_all : elt list -> int -> t -> t

  val remove_all_top : t -> elt list * int * t

  val of_list : (elt * int) list -> t

  val sexp_of_t : t -> Sexp.t

  val t_of_sexp : Sexp.t -> t
end

(** Simple, inefficient implementation of a priority queue. *)
module Simple (Elt : OrderedTypeS) : PriorityQueue with type elt = Elt.t =
struct
  type elt = Elt.t

  (* The priority queue stores elements along with integer priorities. *)
  type t = (elt * int) list

  let empty = []

  let is_empty pq = pq = []

  (* `compare` function for priority queue pairs.
   * The priority values (`i1` and `i2`) have priority (sorry)
   * over `e1` and `e2`. *)
  let priority_compare (e1, i1) (e2, i2) = Stdlib.compare (i1, e2) (i2, e1)

  (* Return `true` if (e1, i1) has a higher priority than
   * (e2, i2).  This occurs if i1 > i2 or if i1 = i2 and
   * e1 < e2 (according to `Elt.compare`).
   * We do it this way because it's completely predictable,
   * which makes testing easier. *)
  let has_higher_priority (e1, i1) (e2, i2) =
    priority_compare (e1, i1) (e2, i2) > 0

  (* This function assumes that `e` is not in the queue. *)
  let rec insert e i pq =
    match pq with
    | [] -> [(e, i)]
    | (e', _) :: _ when Elt.compare e e' = 0 ->
      (* This should never happen. *)
      failwith "can't have duplicate elements in priority queue"
    | (e', i') :: t ->
      if has_higher_priority (e, i) (e', i') then (e, i) :: pq
      else (e', i') :: insert e i t

  let remove_top = function
    | [] -> failwith "no elements in priority queue"
    | (e, _) :: t -> (e, t)

  (* Remove the element `e` from the priority queue.
   * Return None if it's not in the queue, or
   * Some <new queue> if it is. *)
  let remove e pq =
    let rec iter prev rest =
      match rest with
      | [] -> None
      | (h, i) :: t ->
        if Elt.compare h e = 0 then Some (List.rev_append prev t)
        else iter ((h, i) :: prev) t
    in
    iter [] pq

  let update e i pq =
    match remove e pq with
    | None -> pq (* not in priority queue *)
    | Some pq' -> insert e i pq'

  let insert_all es i pq = List.fold_left (fun pq e -> insert e i pq) pq es

  let remove_all_top t : elt list * int * (elt * int) list =
    let rec iter i best rest =
      match rest with
      | (e, j) :: t when j = i -> iter i (e :: best) t
      | _ -> (best, i, rest)
    in
    match t with
    | [] -> failwith "no elements in priority queue"
    | (e, i) :: rest -> iter i [e] rest

  let of_list alist =
    (* Need to negate `priority_compare` result or else
     * the list will be sorted in ascending priority order. *)
    List.sort (fun x y -> -priority_compare x y) alist

  let sexp_of_t pq =
    let sexp_of_binding = sexp_of_pair Elt.sexp_of_t sexp_of_int in
    sexp_of_list sexp_of_binding pq

  let t_of_sexp sexp =
    let binding_of_sexp = pair_of_sexp Elt.t_of_sexp int_of_sexp in
    list_of_sexp binding_of_sexp sexp
end

(* TODO: more efficient implementation based on binary trees. *)
