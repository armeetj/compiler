open Sexplib
open Sexp
open Support.Utils
open Types
open Lfun

(* Variable (identifier) names are allowed to have any
 * of the symbolic characters "+-*/<=>!?:$%_&~^"
 * (not including the double quotes).
 * Scheme allows the '.' character in variable names;
 * we don't because it conflicts with generated names. *)

let var_re = Str.regexp {|[-A-Za-z0-9+*/<=>!?:$%_&~^]+$|}

(* Reserved identifier names; these can't be the names of
 * functions or variables. *)
let reserved_names = [
  "read"; "print";
  "+"; "-"; "="; "<"; "<="; ">"; ">="; "and"; "or"; "not";
  "let"; "if";
  "set!"; "begin"; "while"; "void";
  "vector"; "vector-length"; "vector-ref"; "vector-set!";
  "define"; ":";
  "Void"; "Boolean"; "Integer"; "Vector"; "->";
]

let is_bool s =
  (s = "#t") || (s = "#f")

(* Check to see if a string is an int. *)
let is_int s = Option.is_some (int_of_string_opt s)

(* Check that a variable only contains acceptable characters
 * and is not a bool, int or reserved name. *)
let is_var s = 
  (Str.string_match var_re s 0) 
    && not (is_bool s)
    && not (is_int s)
    && not (List.mem s reserved_names)

(* Operator strings and their abstract syntax counterparts.
 * `Negate has no unique operator since it shares the "-" symbol. *)
let ops = [
  ("read",  `Read);
  ("print", `Print);
  ("+",     `Add);
  ("-",     `Sub);
  ("=",     `Eq);
  ("<",     `Lt);
  ("<=",    `Le);
  (">",     `Gt);
  (">=",    `Ge);
  ("not",   `Not);
]

let op_names = List.map fst ops

(* The concrete syntax of a program is a single Lfun expression. *)
let rec lfun_exp_of_sexp = function
  | List [(Atom "set!"); (Atom v); e] when is_var v ->
      SetBang (v, lfun_exp_of_sexp e)

  | List ((Atom "begin") :: es) ->
    begin
      match List.map lfun_exp_of_sexp es with
        | [] -> failwith "empty `begin` expression"
        | es' -> Begin (butlast es', last es')
    end

  | List [(Atom "while"); e1; e2] ->
      While (lfun_exp_of_sexp e1, lfun_exp_of_sexp e2)

  | List [(Atom "void")] -> Void

  | List [(Atom "let"); List [Atom v; e1]; e2] when is_var v ->
      Let (v, lfun_exp_of_sexp e1, lfun_exp_of_sexp e2)

  | List [(Atom "if"); e1; e2; e3] ->
      If (lfun_exp_of_sexp e1, lfun_exp_of_sexp e2, lfun_exp_of_sexp e3)

  | List [(Atom "and"); e1; e2] ->
      And (lfun_exp_of_sexp e1, lfun_exp_of_sexp e2)

  | List [(Atom "or"); e1; e2] ->
      Or (lfun_exp_of_sexp e1, lfun_exp_of_sexp e2)

  | List (Atom "vector" :: es) ->
      Vec (List.map lfun_exp_of_sexp es, None)

  | List [Atom "vector-length"; e] ->
      VecLen (lfun_exp_of_sexp e)

  | List [Atom "vector-ref"; e1; Atom s] ->
    begin
      match int_of_string_opt s with
        | Some i -> VecRef (lfun_exp_of_sexp e1, i)
        | None -> 
          failwithf
            "%s: `vector-ref` second argument should be a literal integer"
            "invalid `Lfun` input"
    end

  | List [Atom "vector-set!"; e1; Atom s; e2] ->
    begin
      match int_of_string_opt s with
        | Some i -> VecSet (lfun_exp_of_sexp e1, i, lfun_exp_of_sexp e2)
        | None -> 
            failwithf
              "%s: `vector-set!` second argument should be a literal integer"
              "invalid `Lfun` input"
    end

  (* Special operator case: unary minus. *)
  | List [Atom "-"; x] -> Prim (`Negate, [lfun_exp_of_sexp x])

  | List (Atom a :: lst) when List.mem a op_names ->
      let op = List.assoc a ops in
        Prim (op, List.map lfun_exp_of_sexp lst)

  | List (e1 :: es) ->
      Apply (lfun_exp_of_sexp e1, List.map lfun_exp_of_sexp es)

  | Atom s ->
    begin
      match s with
        | "#f" -> Bool false
        | "#t" -> Bool true
        | _ when is_int s -> Int (int_of_string s)
        | _ when is_var s -> Var s
        | _ -> failwithf "invalid variable name: %s" s
    end

  | sx -> failwithf "invalid `Lfun` input: [ %s ]" (Sexp.to_string sx)

let rec lfun_type_of_sexp sx =
  match sx with
    | Atom "Void"    -> Unit
    | Atom "Boolean" -> Boolean
    | Atom "Integer" -> Integer
    | List (Atom "Vector" :: sx_tys) ->
        let tys = Array.of_list (List.map lfun_type_of_sexp sx_tys) in
          Vector tys
    | List ss ->
        (* Function type:
         * must be a list with second-last element the atom `->`. *)
        let len = List.length ss in
          if (len >= 3) && (List.nth ss (len - 2) = Atom "->") then
            let arg_tys = List.map lfun_type_of_sexp (take (len - 2) ss) in
            let ret_ty = lfun_type_of_sexp (last ss) in
              Function (arg_tys, ret_ty)
          else
            failwithf "invalid type: [ %s ]" (Sexp.to_string sx)
    | _ -> failwithf "invalid type: [ %s ]" (Sexp.to_string sx)

let lfun_arg_of_sexp sx =
  match sx with
    | List [Atom a; Atom ":"; sx_type] when is_var a ->
        (a, lfun_type_of_sexp sx_type)
    | _ -> failwithf "invalid function formal argument: [ %s ]"
             (Sexp.to_string sx)

let lfun_def_of_sexp sx =
  match sx with
    | List [Atom "define"; 
            List (Atom name :: sx_args); Atom ":";
            sx_type; sx_exp] ->
        let args = List.map lfun_arg_of_sexp sx_args in
        let ret  = lfun_type_of_sexp sx_type in
        let body = lfun_exp_of_sexp sx_exp in
          Def (name, { args; ret; body })
    | _ -> failwithf "invalid definition: [ %s ]" (Sexp.to_string sx)

let parse_from_sexps ss =
  match ss with
    | [] -> failwith "no forms in file"
    | [exp_sx] ->
      let exp = lfun_exp_of_sexp exp_sx in
        Program ([], exp)
    | _ ->
      let defs_sx = butlast ss in
      let exp_sx  = last ss in
      let defs    = List.map lfun_def_of_sexp defs_sx in
      let exp     = lfun_exp_of_sexp exp_sx in
        Program (defs, exp)

let parse filename =
  parse_from_sexps (load_sexps filename)

