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
  | Atm       of atm
  | Prim      of core_op * atm list
  | Allocate  of int * ty
  | GlobalVal of var
  | VecLen    of atm
  | VecRef    of atm * int
  | VecSet    of atm * int * atm
  | FunRef    of label * int
  | Call      of atm * atm list
[@@deriving sexp]

type stmt =
  | Assign  of var * exp
  | PrimS   of stmt_op * atm list
  | CallS   of atm * atm list
  | Collect of int
  | VecSetS of atm * int * atm
[@@deriving sexp]

type tail =
  | Return   of exp
  | TailCall of atm * atm list
  | Seq      of stmt * tail
  | Goto     of label
  | IfStmt   of {
      op        : cmp_op;
      arg1      : atm;
      arg2      : atm;
      jump_then : label;
      jump_else : label;
    }
[@@deriving sexp]

type fun_contents =
  {
    args   : (var * ty) list;
    ret    : ty;
    locals : (var * ty) list;
    body   : (label * tail) list;
  }
[@@deriving sexp]

type def =
  | Def of label * fun_contents
[@@deriving sexp]

type program = CProgram of def list
[@@deriving sexp]

(* ----------------------------------------------------------------------  
 * Utilities.
 * ---------------------------------------------------------------------- *)

let get_vars (body : (label * tail) list) : var list =
  let add_vars vlst1 vlst2 =
    let vlst2' = List.filter (fun v -> not (List.mem v vlst1)) vlst2 in
      vlst1 @ vlst2'
  in

  let vars_in_atm = function
    | Var v -> [v]
    | _ -> []
  in

  let vars_in_exp = function
    | Atm a ->
        vars_in_atm a
    | Prim (_, atms) ->
        List.concat_map vars_in_atm atms
    | Allocate _ ->
        []
    | GlobalVal v ->
        [v]
    | VecLen a ->
        vars_in_atm a
    | VecRef (a, _) ->
        vars_in_atm a
    | VecSet (a1, _, a2) ->
        (vars_in_atm a1) @ (vars_in_atm a2)
    | FunRef (Label lbl, _) ->
        [lbl]
    | Call (a, atms) ->
        (vars_in_atm a) @ (List.concat_map vars_in_atm atms)
  in

  let vars_in_stmt = function
    | Assign (v, e) ->
        add_vars (vars_in_exp e) [v]
    | PrimS (_, atms) ->
        List.concat_map vars_in_atm atms
    | CallS (atm, atms) ->
        (vars_in_atm atm) @ List.concat_map vars_in_atm atms
    | Collect _ -> []
    | VecSetS (a1, _, a2) ->
        (vars_in_atm a1) @ (vars_in_atm a2)
  in

  let rec vars_in_tail t =
    match t with
      | Return e ->
          vars_in_exp e
      | TailCall (a, atms) ->
          (vars_in_atm a) @ (List.concat_map vars_in_atm atms)
      | Seq (s, t) ->
          add_vars (vars_in_stmt s) (vars_in_tail t)
      | Goto _ ->
          []
      | IfStmt { arg1; arg2; _ } ->
          add_vars (vars_in_atm arg1) (vars_in_atm arg2)
  in
    List.concat_map (fun (_, t) -> vars_in_tail t) body

let rec get_jump_labels (t : tail) : label list =
  match t with
    | Return _    -> []
    | TailCall _  -> []
    | Seq (_, t') -> get_jump_labels t'
    | Goto lbl    -> [lbl]
    | IfStmt { jump_then; jump_else; _ } -> [jump_then; jump_else]

