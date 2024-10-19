(* Tests of the multigraph implementation. *)

open Sexplib
open Sexplib.Conv
open Functors
open Printf

module OrderedIntS = struct
  type t = int

  let compare = Stdlib.compare
  let t_of_sexp = int_of_sexp
  let sexp_of_t = sexp_of_int
  let to_string v = string_of_int v
end

module G = Dgraph.Make (OrderedIntS)

let print_graph g = printf "%s\n" (G.to_string g)

let print_tsort lst =
  let rev = List.rev lst in
  let init = List.rev (List.tl rev) in
  let last = List.hd rev in
  printf "TOPOLOGICAL SORT: [";
  List.iter (fun i -> printf "%d; " i) init;
  printf "%d]\n" last

(* Test transposition and topological sorting. *)

let g = G.of_list [ (1, 2); (2, 3); (1, 3); (3, 1); (2, 3) ];;

print_graph g

let gt = G.transpose g;;

printf "%s\n" (G.to_string gt)

let tsort = G.topological_sort
let g2 = G.of_list [ (0, 1); (1, 2); (2, 3); (2, 3) ];;

print_tsort (tsort ~start:(Some 0) g2)

let g3 =
  G.of_list
    [
      (5, 11);
      (7, 11);
      (7, 8);
      (3, 8);
      (3, 10);
      (11, 2);
      (11, 9);
      (11, 10);
      (8, 9);
    ]
;;

print_graph g3;;
print_tsort (tsort ~start:(Some 5) g3)

let g4 = G.of_list [ (1, 2); (2, 3); (3, 1) ];;

try print_tsort (tsort ~start:(Some 1) g4)
with Failure msg -> printf "ERROR: %s\n" msg

(* Test vertex merging. *)

let g5 = G.of_list [ (1, 2); (1, 3); (2, 3); (3, 4); (4, 5); (4, 6); (1, 6) ];;

print_graph g5

let g6 = G.merge_vertices g5 3 4;;

print_graph g6
