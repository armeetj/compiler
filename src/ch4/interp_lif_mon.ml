open Types
open Interp
open Interp_lif
open Lif_mon

let convert_atm (a : atm) : fexp =
   match a with
     | Bool b -> bool_exp b
     | Int i  -> int_exp i
     | Var v  -> var_exp v

let rec convert_exp (e : exp) : fexp =
  let conv      = convert_exp in
  let aconv     = convert_atm in
  let map_aconv = List.map convert_atm in
    match e with
      | Atm a           -> aconv a
      | Prim (op, args) -> prim_exp op (map_aconv args)
      | If (e1, e2, e3) -> if_exp (conv e1) (conv e2) (conv e3)
      | Let (v, e1, e2) -> let_exp v (conv e1) (conv e2)

let interp (Program exp : program) : int =
  let initial_env = Env.empty in
  let result = convert_exp exp initial_env in
    expect_int ~err_msg:"interp: return value" result

