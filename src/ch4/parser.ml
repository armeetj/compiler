open Sexplib
open Support.Utils
open Sexp
open Lif

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
  | "#f" -> Some false
  | "#t" -> Some true
  | _ -> None

(* Operator strings and their abstract syntax counterparts.
 * `Negate has no unique operator since it shares the "-" symbol. *)
let ops = [
  ("read", `Read);
  ("+",    `Add);
  ("-",    `Sub);
  ("eq?",  `Eq);
  ("<",    `Lt);
  ("<=",   `Le);
  (">",    `Gt);
  (">=",   `Ge);
  ("not",  `Not);
]

(* The concrete syntax of a program is a single Lif expression. *)
let rec lif_exp_of_sexp = function
  | List [(Atom "let"); List [Atom v; e1]; e2] 
      when is_var v && not (is_int v) ->
        Let (v, lif_exp_of_sexp e1, lif_exp_of_sexp e2)

  | List [(Atom "if"); e1; e2; e3] ->
      If (lif_exp_of_sexp e1, lif_exp_of_sexp e2, lif_exp_of_sexp e3)

  | List [(Atom "and"); e1; e2] ->
      And (lif_exp_of_sexp e1, lif_exp_of_sexp e2)

  | List [(Atom "or"); e1; e2] ->
      Or (lif_exp_of_sexp e1, lif_exp_of_sexp e2)

  (* Special operator case: unary minus. *)
  | List [Atom "-"; x] -> Prim (`Negate, [lif_exp_of_sexp x])

  | List (Atom a :: lst) ->
    begin
      match List.assoc_opt a ops with
        | Some op -> Prim (op, List.map lif_exp_of_sexp lst)
        | None -> failwithf "invalid `Lif` input: invalid operator: %s" a
    end

  | Atom s ->
    begin
      (* Check to see if the atom is an int. *)
      match int_of_string_opt s with
        | None   ->
          begin
            (* Check to see if the atom is a bool. *)
            match bool_of_string_opt s with
              | None ->
                (* Check to see if the atom is a valid variable name. *)
                if is_var s then
                  Var s
                else
                  failwithf "invalid variable name: %s" s
              | Some b -> Bool b
          end

        | Some i -> Int i
    end

  | _ -> failwith "invalid `Lif` input"

let parse_from_sexp sx =
  let exp = lif_exp_of_sexp sx in
    Program exp

let parse filename =
  parse_from_sexp (load_sexp filename)

