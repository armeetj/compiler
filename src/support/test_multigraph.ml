(* Tests of the multigraph implementation. *)

open Sexplib
open Sexplib.Conv
open Functors
open Printf

module OrderedStringS = struct
  type t = string

  let compare = Stdlib.compare

  let t_of_sexp = string_of_sexp

  let sexp_of_t = sexp_of_string

  let to_string v = v
end

module G = Multigraph.Make (OrderedStringS)

let print_graph g = printf "%s\n" (G.to_string g)

let print_tsort lst =
  let rev = List.rev lst in
  let init = List.rev (List.tl rev) in
  let last = List.hd rev in
  printf "TOPOLOGICAL SORT: [" ;
  List.iter (fun s -> printf "%s; " s) init ;
  printf "%s]\n" last

let graph_of_nums nums =
  G.of_list (List.map (fun (x, y) -> (string_of_int x, string_of_int y)) nums)

(* Test transposition and topological sorting. *)

let g = G.of_list [("a", "b"); ("b", "c"); ("a", "c"); ("c", "a"); ("b", "c")]
;;

print_graph g

let gt = G.transpose g ;;

printf "%s\n" (G.to_string gt)

let tsort = G.topological_sort

let g2 = G.of_list [("start", "x"); ("x", "y"); ("y", "z"); ("y", "z")] ;;

print_tsort (tsort ~start:(Some "start") g2)

let g3 =
  graph_of_nums
    [ (5, 11)
    ; (7, 11)
    ; (7, 8)
    ; (3, 8)
    ; (3, 10)
    ; (11, 2)
    ; (11, 9)
    ; (11, 10)
    ; (8, 9) ]
;;

print_graph g3 ;;

print_tsort (tsort ~start:(Some "5") g3)

let g4 = graph_of_nums [(1, 2); (2, 3); (3, 1)] ;;

try print_tsort (tsort ~start:(Some "1") g4)
with Failure msg -> printf "ERROR: %s\n" msg
