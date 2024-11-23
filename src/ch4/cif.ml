open Sexplib.Std
open Support.Utils
open Types

(* ----------------------------------------------------------------------  
 * Types.
 * ---------------------------------------------------------------------- *)

type atm = Bool of bool | Int of int | Var of var [@@deriving sexp]

type exp = Atm of atm | Prim of core_op * atm list [@@deriving sexp]

type stmt = Assign of var * exp [@@deriving sexp]

type tail =
  | Return of exp
  | Seq of stmt * tail
  | Goto of label
  | IfStmt of
      {op : cmp_op; arg1 : atm; arg2 : atm; jump_then : label; jump_else : label}
[@@deriving sexp]

type info = Info of {locals_types : (var * ty) list} [@@deriving sexp]

type program = CProgram of info * (label * tail) list [@@deriving sexp]

(* ----------------------------------------------------------------------  
 * Utilities.
 * ---------------------------------------------------------------------- *)

let get_vars (prog : program) : var list =
  let (CProgram (_, lts)) = prog in
  let add_vars (vlst1 : var list) (vlst2 : var list) : var list =
    let vlst2' = List.filter (fun v -> not (List.mem v vlst1)) vlst2 in
    vlst1 @ vlst2'
  in
  let combine_vars (var_lists : var list list) : var list =
    List.fold_left (fun prev vars -> add_vars prev vars) [] var_lists
  in
  let vars_in_atm = function Var v -> [v] | _ -> [] in
  let vars_in_exp = function
    | Atm a ->
        vars_in_atm a
    | Prim (_, atms) ->
        combine_vars (List.map vars_in_atm atms)
  in
  let vars_in_stmt (Assign (v, e)) = add_vars (vars_in_exp e) [v] in
  let rec vars_in_tail t =
    match t with
    | Return e ->
        vars_in_exp e
    | Seq (s, t) ->
        add_vars (vars_in_stmt s) (vars_in_tail t)
    | Goto _ ->
        []
    | IfStmt {arg1; arg2; _} ->
        add_vars (vars_in_atm arg1) (vars_in_atm arg2)
  in
  combine_vars (List.map (fun (_, t) -> vars_in_tail t) lts)

let rec get_jump_labels (t : tail) : label list =
  match t with
  | Return _ ->
      []
  | Seq (_, t') ->
      get_jump_labels t'
  | Goto lbl ->
      [lbl]
  | IfStmt {jump_then; jump_else; _} ->
      [jump_then; jump_else]

let tsort_lts (lts : (label * tail) list) : (label * tail) list =
  let lt_map = LabelMap.of_list lts in
  let start_name = "start" in
  let start_label = Label start_name in
  (* Check that the start label is in the map. *)
  let _ =
    if not (LabelMap.mem start_label lt_map) then
      failwithf "tsort_lts: start label (%s) not found in (label, tail) list"
        start_name
    else ()
  in
  (* Create a graph from the labels and topologically sort the graph. *)
  let (graph_list : (label * label) list) =
    List.concat_map
      (fun (l, t) ->
        List.map
          (fun l_next -> (l, l_next)) (* graph edge l -> l_next *)
          (get_jump_labels t) )
      lts
  in
  let (graph : LabelMgraph.t) =
    if graph_list = [] then
      (* Graph has no edges.  Make a graph from the labels only.
       * This should only be the "start" label. *)
      let keys = LabelMap.keys lt_map in
      if keys <> [Label "start"] then
        failwith "tsort_lts: more than one label with no edges"
      else LabelMgraph.add_vertex LabelMgraph.empty (Label "start")
    else LabelMgraph.of_list graph_list
  in
  let tsorted_labels =
    LabelMgraph.topological_sort ~start:(Some start_label) graph
  in
  List.map
    (fun lbl ->
      let tail = LabelMap.find lbl lt_map in
      (lbl, tail) )
    tsorted_labels
