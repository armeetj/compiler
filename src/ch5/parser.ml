open Sexplib
open Sexp
open Support.Utils
open Lwhile

(* Variable names are allowed to have any of the symbolic characters
 * "+-*/<=>!?:$%_&~^" (not including the double quotes).
 * Scheme allows the '.' character in variable names;
 * we don't because it may conflict with generated names. *)

let var_re = Str.regexp {|[-A-Za-z0-9+*/<=>!?:$%_&~^]+$|}

(* Check that a variable only contains acceptable characters. *)
let is_var s = Str.string_match var_re s 0

(* Check to see if a string is an int. *)
let is_int s = Option.is_some (int_of_string_opt s)

(* Convert a string to a boolean if possible.
   Overrides the library function of the same name. *)
let bool_of_string_opt = function
  | "#f" ->
      Some false
  | "#t" ->
      Some true
  | _ ->
      None

(* Operator strings and their abstract syntax counterparts.
 * `Negate has no unique operator since it shares the "-" symbol. *)
let ops =
  [ ("read", `Read)
  ; ("print", `Print)
  ; ("+", `Add)
  ; ("-", `Sub)
  ; ("eq?", `Eq)
  ; ("<", `Lt)
  ; ("<=", `Le)
  ; (">", `Gt)
  ; (">=", `Ge)
  ; ("not", `Not) ]

(* The concrete syntax of a program is a single Lwhile expression. *)
let rec lwhile_exp_of_sexp = function
  | List [Atom "set!"; Atom v; e] ->
      SetBang (v, lwhile_exp_of_sexp e)
  | List (Atom "begin" :: es) -> (
    match List.map lwhile_exp_of_sexp es with
    | [] ->
        failwith "empty `begin` expression"
    | es' ->
        Begin (butlast es', last es') )
  | List [Atom "while"; e1; e2] ->
      While (lwhile_exp_of_sexp e1, lwhile_exp_of_sexp e2)
  | List [Atom "void"] ->
      Void
  | List [Atom "let"; List [Atom v; e1]; e2] when is_var v && not (is_int v) ->
      Let (v, lwhile_exp_of_sexp e1, lwhile_exp_of_sexp e2)
  | List [Atom "if"; e1; e2; e3] ->
      If (lwhile_exp_of_sexp e1, lwhile_exp_of_sexp e2, lwhile_exp_of_sexp e3)
  | List [Atom "and"; e1; e2] ->
      And (lwhile_exp_of_sexp e1, lwhile_exp_of_sexp e2)
  | List [Atom "or"; e1; e2] ->
      Or (lwhile_exp_of_sexp e1, lwhile_exp_of_sexp e2)
  (* Special operator case: unary minus. *)
  | List [Atom "-"; x] ->
      Prim (`Negate, [lwhile_exp_of_sexp x])
  | List (Atom a :: lst) -> (
    match List.assoc_opt a ops with
    | Some op ->
        Prim (op, List.map lwhile_exp_of_sexp lst)
    | None ->
        failwithf "invalid `Lwhile` input: invalid operator: %s" a )
  | Atom s -> (
    (* Check to see if the atom is an int. *)
    match int_of_string_opt s with
    | None -> (
      (* Check to see if the atom is a bool. *)
      match bool_of_string_opt s with
      | None ->
          (* Check to see if the atom is a valid variable name. *)
          if is_var s then Var s else failwithf "invalid variable name: %s" s
      | Some b ->
          Bool b )
    | Some i ->
        Int i )
  | _ ->
      failwith "invalid `Lwhile` input"

let parse_from_sexp sx =
  let exp = lwhile_exp_of_sexp sx in
  Program exp

let parse filename = parse_from_sexp (load_sexp filename)
