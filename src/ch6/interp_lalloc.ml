open Support.Utils
open Types
open Type_check
open Interp
open Interp_utils
open Interp_ltup
open Lalloc

let rec default_val (t : ty) : value =
  match t with
  | Unit -> VoidV
  | Boolean -> BoolV false
  | Integer -> IntV 0
  | Vector ts -> VecV (Array.map default_val ts)

let collect_exp i _ = collect i ; VoidV

let allocate_exp i t _ =
  match t with
  | Vector ts ->
    (* Return an "uninitialized" value of a vector type. *)
    if Array.length ts <> i then
      failwithf "interp_exp: malformed `Allocate` case"
    else
      (* Compute the allocation size in bytes,
           which is (8 * (i + 1))
           i.e. 8 bytes for each slot + 8 bytes for the tag.
           Allocate the memory and return a vector of uninitialized values. *)
      let size = 8 * (i + 1) in
      allocate size ;
      VecV (Array.map default_val ts)
  | _ -> failwithf "interp_exp: can't allocate type (%s)" (string_of_ty t)

let global_var_exp v _ =
  match v with
  | "free_ptr" -> IntV !free_ptr
  | "fromspace_end" -> IntV !fromspace_end
  | _ -> failwithf "interp_exp: unknown global variable (%s)" v

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
