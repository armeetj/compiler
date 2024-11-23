open Sexplib.Std
open Types

(* ----------------------------------------------------------------------  
 * Types.
 * ---------------------------------------------------------------------- *)

type atm = Int of int | Var of var [@@deriving sexp]

type exp =
  | Atm of atm
  | Read (* read an integer from stdin *)
  | Negate of atm
  | Add of atm * atm
  | Sub of atm * atm
[@@deriving sexp]

type stmt = Assign of var * exp [@@deriving sexp]

type tail = Return of exp | Seq of stmt * tail [@@deriving sexp]

type info = Info of {locals_types : (var * ty) list} [@@deriving sexp]

type program = CProgram of info * (label * tail) list [@@deriving sexp]

(* ----------------------------------------------------------------------  
 * Utilities.
 * ---------------------------------------------------------------------- *)

(* Extract all the variables from a Cvar program.
   Make sure that there are no duplicates and that
   variables are extracted in order. *)
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
    | Negate a ->
        vars_in_atm a
    | Add (a1, a2) | Sub (a1, a2) ->
        add_vars (vars_in_atm a1) (vars_in_atm a2)
    | _ ->
        []
  in
  let vars_in_stmt (Assign (v, e)) = add_vars (vars_in_exp e) [v] in
  let rec vars_in_tail t =
    match t with
    | Return e ->
        vars_in_exp e
    | Seq (s, t) ->
        add_vars (vars_in_stmt s) (vars_in_tail t)
  in
  combine_vars (List.map (fun (_, t) -> vars_in_tail t) lts)

(* Add type information to a Cvar program. *)
let add_type_info (CProgram (_, lts) as p) =
  let vars = get_vars p in
  let info = List.map (fun v -> (v, Integer)) vars in
  CProgram (Info {locals_types = info}, lts)
