(* A little script to test the graph coloring algorithm
 * against the example given in the book. *)

open Sexplib
open Support
open Functors
open Types
open Utils

let sexp_of_string = Sexp.of_string

let check_bindings_equal b1 b2 =
  let m1 = LocMap.of_list b1 in
  let m2 = LocMap.of_list b2 in
    LocMap.equal (=) m1 m2

module LocMap = MapS.Make (OrderedLoc)
module G      = Ugraph.Make (OrderedLoc)
module PQ     = Priority_queue.Simple (OrderedLoc)
module Color  = Graph_coloring.Make (OrderedLoc) (LocMap) (PQ) (G)

let precolored =
  LocMap.of_list
    [(RegL Rsp, -2); 
     (RegL Rax, -1)]

let get_bindings graph_str =
  let graph_sexp    = sexp_of_string graph_str in
  (* let _ = print_sexp graph_sexp *)
  let graph_of_sexp = G.t_of_sexp in
  let graph         = graph_of_sexp graph_sexp in
  let color         = Color.color graph precolored in
    LocMap.bindings color

(* ---------------------------------------------------------------------- 
 * Test 1.
 * ---------------------------------------------------------------------- *)

let graph_str_1 = "
(((VarL t)
  ((VarL z)
   (RegL Rsp)
   (RegL Rax)))
 ((VarL v)
  ((VarL w)
   (RegL Rsp)))
 ((VarL w)
  ((VarL v)
   (VarL x)
   (VarL y)
   (VarL z)
   (RegL Rsp)))
 ((VarL x)
  ((VarL w)
   (RegL Rsp)))
 ((VarL y)
  ((VarL w)
   (VarL z)
   (RegL Rsp)))
 ((VarL z)
  ((VarL t)
   (VarL w)
   (VarL y)
   (RegL Rsp)))
 ((RegL Rsp)
  ((VarL t)
   (VarL v)
   (VarL w)
   (VarL x)
   (VarL y)
   (VarL z)
   (RegL Rax)))
 ((RegL Rax)
  ((VarL t)
   (RegL Rsp))))
"

let expected_bindings_1 : (location * int) list =
  [(VarL "t", 0); (VarL "v", 1); (VarL "w", 0);
   (VarL "x", 1); (VarL "y", 2); (VarL "z", 1);
   (RegL Rsp, -2); (RegL Rax, -1)]

(* NOTE: t, w -> 0; v, x, z -> 1, y -> 2 *)

let bindings_1 = get_bindings graph_str_1

let _ =
  if check_bindings_equal expected_bindings_1 bindings_1 then
    Printf.printf "TEST PASSED!\n\n%!"
  else
    Printf.printf "TEST FAILED!\n\n%!"

