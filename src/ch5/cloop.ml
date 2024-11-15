open Sexplib.Std
open Types

(* ----------------------------------------------------------------------  
 * Types.
 * ---------------------------------------------------------------------- *)

type atm =
  | Void
  | Bool of bool
  | Int  of int
  | Var  of var
[@@deriving sexp]

type exp =
  | Atm  of atm
  | Prim of core_op * atm list
[@@deriving sexp]

type stmt =
  | Assign of var * exp
  | PrimS  of stmt_op * atm list
[@@deriving sexp]

(** Statements in tail position. *)
type tail =
  | Return of exp
  | Seq    of stmt * tail
  | Goto   of label
  | IfStmt of {
      op        : cmp_op;
      arg1      : atm;
      arg2      : atm;
      jump_then : label;
      jump_else : label;
    }
[@@deriving sexp]

type info = Info of { locals_types : (var * ty) list }
[@@deriving sexp]

type program = CProgram of info * (label * tail) list
[@@deriving sexp]

(* ----------------------------------------------------------------------  
 * Utilities.
 * ---------------------------------------------------------------------- *)

let get_vars (prog : program) : var list =
  let CProgram (_, lts) = prog in

  let add_vars (vlst1 : var list) (vlst2 : var list) : var list =
    let vlst2' = List.filter (fun v -> not (List.mem v vlst1)) vlst2 in
      vlst1 @ vlst2'
  in

  let combine_vars (var_lists : var list list) : var list =
    List.fold_left
      (fun prev vars -> add_vars prev vars)
      []
      var_lists
  in

  let vars_in_atm = function
    | Var v -> [v]
    | _ -> []
  in

  let vars_in_exp = function
    | Atm a ->
        vars_in_atm a
    | Prim (_, atms) ->
        combine_vars (List.map vars_in_atm atms)
  in

  let vars_in_stmt = function
    | Assign (v, e) ->
        add_vars (vars_in_exp e) [v]
    | PrimS (_, atms) ->
        combine_vars (List.map vars_in_atm atms)
  in

  let rec vars_in_tail t =
    match t with
      | Return e ->
          vars_in_exp e
      | Seq (s, t) ->
          add_vars (vars_in_stmt s) (vars_in_tail t)
      | Goto _ ->
          []
      | IfStmt { arg1; arg2; _ } ->
          add_vars (vars_in_atm arg1) (vars_in_atm arg2)
  in
    combine_vars (List.map (fun (_, t) -> vars_in_tail t) lts)

let rec get_jump_labels (t : tail) : label list =
  match t with
    | Return _ -> []
    | Seq (_, t') ->
        get_jump_labels t'
    | Goto lbl ->
        [lbl]
    | IfStmt { jump_then; jump_else; _ } ->
        [jump_then; jump_else]

