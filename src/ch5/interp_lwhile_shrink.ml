open Types
open Interp
open Interp_lwhile
open Lwhile_shrink

let rec convert_exp (e : exp) : fexp =
  let conv = convert_exp in
  let map_conv = List.map conv in
    match e with
      | Void               -> void_exp
      | Bool b             -> bool_exp b
      | Int i              -> int_exp i
      | Var v              -> var_exp v
      | Prim (op, args)    -> prim_exp op (map_conv args)
      | SetBang (v, e)     -> set_bang_exp v (conv e)
      | Begin (es, e)      -> begin_exp (map_conv es) (conv e)
      | If (e1, e2, e3)    -> if_exp (conv e1) (conv e2) (conv e3)
      | While (e1, e2)     -> while_exp (conv e1) (conv e2)
      | Let (v, e1, e2)    -> let_exp v (conv e1) (conv e2)

let interp (Program exp : program) : int =
  let initial_env = Env.empty in
  let result = convert_exp exp initial_env in
    expect_int ~err_msg:"interp: return value" result

