open Sexplib
open Sexp
open Support.Utils
open Ltup

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

(* The concrete syntax of a program is a single Ltup expression. *)
let rec ltup_exp_of_sexp = function
  | List [Atom "set!"; Atom v; e] ->
      SetBang (v, ltup_exp_of_sexp e)
  | List (Atom "begin" :: es) -> (
    match List.map ltup_exp_of_sexp es with
    | [] ->
        failwith "empty `begin` expression"
    | es' ->
        Begin (butlast es', last es') )
  | List [Atom "while"; e1; e2] ->
      While (ltup_exp_of_sexp e1, ltup_exp_of_sexp e2)
  | List [Atom "void"] ->
      Void
  | List [Atom "let"; List [Atom v; e1]; e2] when is_var v && not (is_int v) ->
      Let (v, ltup_exp_of_sexp e1, ltup_exp_of_sexp e2)
  | List [Atom "if"; e1; e2; e3] ->
      If (ltup_exp_of_sexp e1, ltup_exp_of_sexp e2, ltup_exp_of_sexp e3)
  | List [Atom "and"; e1; e2] ->
      And (ltup_exp_of_sexp e1, ltup_exp_of_sexp e2)
  | List [Atom "or"; e1; e2] ->
      Or (ltup_exp_of_sexp e1, ltup_exp_of_sexp e2)
  | List (Atom "vector" :: es) ->
      Vec (List.map ltup_exp_of_sexp es, None)
  | List [Atom "vector-length"; e] ->
      VecLen (ltup_exp_of_sexp e)
  | List [Atom "vector-ref"; e1; Atom s] -> (
    match int_of_string_opt s with
    | Some i ->
        VecRef (ltup_exp_of_sexp e1, i)
    | None ->
        failwithf "%s: `vector-ref` second argument should be a literal integer"
          "invalid `Ltup` input" )
  | List [Atom "vector-set!"; e1; Atom s; e2] -> (
    match int_of_string_opt s with
    | Some i ->
        VecSet (ltup_exp_of_sexp e1, i, ltup_exp_of_sexp e2)
    | None ->
        failwithf
          "%s: `vector-set!` second argument should be a literal integer"
          "invalid `Ltup` input" )
  (* Special operator case: unary minus. *)
  | List [Atom "-"; x] ->
      Prim (`Negate, [ltup_exp_of_sexp x])
  | List (Atom a :: lst) -> (
    match List.assoc_opt a ops with
    | Some op ->
        Prim (op, List.map ltup_exp_of_sexp lst)
    | None ->
        failwithf "invalid `Ltup` input: invalid operator: %s" a )
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
  | sx ->
      failwithf "invalid `Ltup` input: [ %s ]" (Sexp.to_string sx)

let parse_from_sexp sx =
  let exp = ltup_exp_of_sexp sx in
  Program exp

let parse filename = parse_from_sexp (load_sexp filename)
