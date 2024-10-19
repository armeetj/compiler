open Sexplib
open Support.Utils
open Sexp
open Lvar

(* Variable names are allowed to have any of the symbolic characters
 * "+-*/<=>!?:$%_&~^" (not including the double quotes).
 * Scheme allows the '.' character in variable names;
 * we don't because it may conflict with generated names. *)

let var_re = Str.regexp {|[-A-Za-z0-9+*/<=>!?:$%_&~^]+$|}

(* Check that a variable only contains acceptable characters. *)
let is_var s = Str.string_match var_re s 0

(* Check to see if a string is an int. *)
let is_int s = match int_of_string_opt s with None -> false | Some _ -> true

(* The concrete syntax of a program is a single Lvar expression. *)
let rec lvar_exp_of_sexp = function
  | List [ Atom "let"; List [ Atom v; e1 ]; e2 ] when is_var v && not (is_int v)
    ->
      Let (v, lvar_exp_of_sexp e1, lvar_exp_of_sexp e2)
  | List [ Atom "read" ] -> Read
  | List [ Atom "-"; e ] -> Negate (lvar_exp_of_sexp e)
  | List [ Atom "+"; e1; e2 ] ->
      let e1' = lvar_exp_of_sexp e1 in
      let e2' = lvar_exp_of_sexp e2 in
      Add (e1', e2')
  | List [ Atom "-"; e1; e2 ] ->
      let e1' = lvar_exp_of_sexp e1 in
      let e2' = lvar_exp_of_sexp e2 in
      Sub (e1', e2')
  | Atom s -> (
      match int_of_string_opt s with
      | None ->
          if is_var s then Var s else failwithf "invalid variable name: %s" s
      | Some i -> Int i)
  | _ -> failwith "invalid `Lvar` input"

let parse filename =
  let exp = lvar_exp_of_sexp (load_sexp filename) in
  Program exp
