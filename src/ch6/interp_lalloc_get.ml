open Types
open Interp
open Interp_utils
open Interp_ltup
open Interp_lalloc
open Lalloc_get

let get_bang_exp v env =
  let loc =
    Env.find_or_fail v env ~err_msg:(Printf.sprintf "variable (%s) not found" v)
  in
  !loc

let rec convert_exp (e : exp) : fexp =
  let conv = convert_exp in
  let map_conv = List.map conv in
  match e with
  | Void -> void_exp
  | Bool b -> bool_exp b
  | Int i -> int_exp i
  | Var v -> var_exp v
  | Prim (op, args) -> prim_exp op (map_conv args)
  | SetBang (v, e) -> set_bang_exp v (conv e)
  | GetBang v -> get_bang_exp v
  | Begin (es, e) -> begin_exp (map_conv es) (conv e)
  | If (e1, e2, e3) -> if_exp (conv e1) (conv e2) (conv e3)
  | While (e1, e2) -> while_exp (conv e1) (conv e2)
  | Let (v, e1, e2) -> let_exp v (conv e1) (conv e2)
  | Collect i -> collect_exp i
  | Allocate (i, t) -> allocate_exp i t
  | GlobalVal v -> global_var_exp v
  | VecLen e -> vec_len_exp (conv e)
  | VecRef (e, i) -> vec_ref_exp (conv e) i
  | VecSet (e1, i, e2) -> vec_set_exp (conv e1) i (conv e2)

let interp (Program exp : program) : int =
  let _ = init_gc_globals () in
  let initial_env = Env.empty in
  let result = convert_exp exp initial_env in
  expect_int ~err_msg:"interp: return value" result
