open Support.Utils
open Types

(* ----------------------------------------------------------------------
 * Types used in interpreters.
 * ---------------------------------------------------------------------- *)

type simple_value = [`VoidV | `BoolV of bool | `IntV of int]

type value =
  [simple_value | `VecV of value array | `FunV of fun_value * env_t option ref]

and env_t = value ref Env.t

and fexp = env_t -> value

and fun_value =
  {vargs : (var * ty) list; vret : ty (* return type *); vbody : fexp}

(* ----------------------------------------------------------------------
 * Operations on simple values (void, bool, int).
 * ---------------------------------------------------------------------- *)

let interp_cmp_op_simple (op : cmp_op) (args : [> simple_value] list) :
  simple_value =
  match (op, args) with
  | `Eq, [`VoidV; `VoidV] -> `BoolV true
  | `Eq, [`IntV i1; `IntV i2] -> `BoolV (i1 = i2)
  | `Eq, [`BoolV b1; `BoolV b2] -> `BoolV (b1 = b2)
  | `Eq, [_; _] -> failwith "interp_op: = : invalid types"
  | `Eq, _ -> failwith "interp_op: = : wrong number of arguments"
  | `Lt, [`IntV i1; `IntV i2] -> `BoolV (i1 < i2)
  | `Lt, [_; _] -> failwith "interp_op: < : invalid types"
  | `Lt, _ -> failwith "interp_op: < : wrong number of arguments"
  | `Le, [`IntV i1; `IntV i2] -> `BoolV (i1 <= i2)
  | `Le, [_; _] -> failwith "interp_op: <= : invalid types"
  | `Le, _ -> failwith "interp_op: <= : wrong number of arguments"
  | `Gt, [`IntV i1; `IntV i2] -> `BoolV (i1 > i2)
  | `Gt, [_; _] -> failwith "interp_op: > : invalid types"
  | `Gt, _ -> failwith "interp_op: > : wrong number of arguments"
  | `Ge, [`IntV i1; `IntV i2] -> `BoolV (i1 >= i2)
  | `Ge, [_; _] -> failwith "interp_op: >= : invalid types"
  | `Ge, _ -> failwith "interp_op: >= : wrong number of arguments"

let interp_stmt_op_simple (op : stmt_op) (args : [> simple_value] list) :
  simple_value =
  match (op, args) with
  | `Read, [] -> `IntV (read_int ())
  | `Read, _ -> failwith "interp_op: read : wrong number of arguments"
  | `Print, [`IntV i] -> Printf.printf "%d\n" i ; `VoidV
  | `Print, [_] -> failwith "interp_op: print : wrong type"
  | `Print, _ -> failwith "interp_op: read : wrong number of arguments"

let interp_core_op_simple (op : core_op) (args : [> simple_value] list) :
  simple_value =
  match (op, args) with
  | `Read, [] -> `IntV (read_int ())
  | `Read, _ -> failwith "interp_op: read : wrong number of arguments"
  | `Print, [`IntV i] -> Printf.printf "%d\n" i ; `VoidV
  | `Print, [_] -> failwith "interp_op: print : wrong type"
  | `Print, _ -> failwith "interp_op: read : wrong number of arguments"
  | `Add, [`IntV i1; `IntV i2] -> `IntV (i1 + i2)
  | `Add, [_; _] -> failwith "interp_op: + : invalid types"
  | `Add, _ -> failwith "interp_op: + : wrong number of arguments"
  | `Sub, [`IntV i1; `IntV i2] -> `IntV (i1 - i2)
  | `Sub, [_; _] -> failwith "interp_op: - : invalid types"
  | `Sub, _ -> failwith "interp_op: - : wrong number of arguments"
  | `Negate, [`IntV i] -> `IntV (-i)
  | `Negate, [_] -> failwith "interp_op: unary - : wrong type"
  | `Negate, _ -> failwith "interp_op: unary - : wrong number of arguments"
  | `Not, [`BoolV b] -> `BoolV (not b)
  | `Not, [_] -> failwith "interp_op: not : wrong type"
  | `Not, _ -> failwith "interp_op: not : wrong number of arguments"
  | (#cmp_op as op), args -> interp_cmp_op_simple op args

(* ----------------------------------------------------------------------
 * Utility functions.
 * ---------------------------------------------------------------------- *)

let rec string_of_value = function
  | `VoidV -> "#<void>"
  | `BoolV b -> if b then "#t" else "#f"
  | `IntV i -> string_of_int i
  | `VecV vs ->
    let vs' = Array.to_list vs in
    "[" ^ String.concat ", " (List.map string_of_value vs') ^ "]"
  | `FunV _ -> "#<fun>"

let expect_int ~err_msg ~to_string = function
  | `IntV i -> i
  | v -> failwithf "%s should be an int, but got (%s)" err_msg (to_string v)
