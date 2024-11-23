open Types

(* ----------------------------------------------------------------------  
 * Types and exceptions.
 * ---------------------------------------------------------------------- *)

exception Type_error of string

type ty_env_t = ty Types.Env.t

let rec string_of_ty = function
  | Unit ->
      "Unit"
  | Boolean ->
      "Boolean"
  | Integer ->
      "Integer"
  | Vector ts ->
      let ts' = Array.to_list ts in
      Printf.sprintf "Vector%s" (string_of_ty_list ts')

and string_of_ty_list (tys : ty list) : string =
  "[" ^ String.concat "; " (List.map string_of_ty tys) ^ "]"

(* ----------------------------------------------------------------------  
 * Operators.
 * ---------------------------------------------------------------------- *)

let get_op_types op =
  match op with
  | `Read ->
      ([], Integer)
  | `Print ->
      ([Integer], Unit)
  | `Add ->
      ([Integer; Integer], Integer)
  | `Sub ->
      ([Integer; Integer], Integer)
  | `Negate ->
      ([Integer], Integer)
  | `Not ->
      ([Boolean], Boolean)
  | `Lt ->
      ([Integer; Integer], Boolean)
  | `Le ->
      ([Integer; Integer], Boolean)
  | `Gt ->
      ([Integer; Integer], Boolean)
  | `Ge ->
      ([Integer; Integer], Boolean)
  | `Eq ->
      failwith "get_op_types: = has a polymorphic type"

let get_op_types_ret op : ty =
  match op with
  | `Read ->
      Integer
  | `Print ->
      Unit
  | `Add ->
      Integer
  | `Sub ->
      Integer
  | `Negate ->
      Integer
  | `Not ->
      Boolean
  | `Lt ->
      Boolean
  | `Le ->
      Boolean
  | `Gt ->
      Boolean
  | `Ge ->
      Boolean
  | `Eq ->
      Boolean

(* ----------------------------------------------------------------------  
 * Utilities.
 * ---------------------------------------------------------------------- *)

let empty_ty_env = Types.Env.empty

(* Type equality in monomorphic type systems is just regular equality. *)
let ty_equal t1 t2 = t1 = t2

let ty_lists_equal t1 t2 = t1 = t2

let ty_err_simple (msg : string) =
  raise (Type_error (Printf.sprintf "type error: %s" msg))

let ty_err (msg : string) ~(expected : ty) ~(got : ty) =
  raise
  @@ Type_error
       (Printf.sprintf "type error: %s : expected %s, got %s" msg
          (string_of_ty expected) (string_of_ty got) )

let ty_list_err (opname : string) ~(expected : ty list) ~(got : ty list) =
  let len1 = List.length expected in
  let len2 = List.length got in
  let err_msg_arity =
    Printf.sprintf "arg types arity error: %s: expected %d args, got %d" opname
      len1 len2
  in
  let err_msg_tys =
    Printf.sprintf "arg types error: %s: expected %s, got %s" opname
      (string_of_ty_list expected)
      (string_of_ty_list got)
  in
  let err_msg = if len1 <> len2 then err_msg_arity else err_msg_tys in
  raise (Type_error err_msg)

(* ----------------------------------------------------------------------  
 * Operators.
 * ---------------------------------------------------------------------- *)

let type_check_op (op : [< core_op]) (arg_tys : ty list) : ty =
  (* `Eq is special-cased because it has a polymorphic type. *)
  match (op, arg_tys) with
  | `Eq, [t1; t2] when ty_equal t1 t2 ->
      Boolean
  | `Eq, _ ->
      ty_err_simple "eq? : both arguments must have the same type"
  | (#core_op as op'), _ ->
      let expected_arg_tys, ret_ty = get_op_types op' in
      if not (ty_lists_equal expected_arg_tys arg_tys) then
        ty_list_err (string_of_op op') ~expected:expected_arg_tys ~got:arg_tys
      else ret_ty

let type_check_op_ret (op : [< core_op]) : ty = get_op_types_ret op
