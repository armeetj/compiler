open Interp
open Interp_utils
open Interp_lfun
open Interp_lfun_shrink
open Interp_lfun_ref
open Interp_lfun_ref_alloc
open Lfun_ref_mon

let convert_atm (a : atm) : fexp =
  match a with
  | Void -> void_exp
  | Bool b -> bool_exp b
  | Int i -> int_exp i
  | Var v -> var_exp v

let rec convert_exp (e : exp) : fexp =
  let conv = convert_exp in
  let map_conv = List.map conv in
  let aconv = convert_atm in
  let map_aconv = List.map convert_atm in
  match e with
  | Atm a -> aconv a
  | FunRef (f, i) -> fun_ref_exp f i
  | Prim (op, args) -> prim_exp op (map_aconv args)
  | SetBang (v, e) -> set_bang_exp v (conv e)
  | Begin (es, e) -> begin_exp (map_conv es) (conv e)
  | If (e1, e2, e3) -> if_exp (conv e1) (conv e2) (conv e3)
  | While (e1, e2) -> while_exp (conv e1) (conv e2)
  | Let (v, e1, e2) -> let_exp v (conv e1) (conv e2)
  | Collect i -> collect_exp i
  | Allocate (i, t) -> allocate_exp i t
  | GlobalVal v -> global_var_exp v
  | VecLen a -> vec_len_exp (aconv a)
  | VecRef (a, i) -> vec_ref_exp (aconv a) i
  | VecSet (a1, i, a2) -> vec_set_exp (aconv a1) i (aconv a2)
  | Apply (a, atms) -> apply_exp (aconv a) (map_aconv atms)

let convert_fun (f : fun_contents) : fun_value =
  {vargs = f.args; vret = f.ret; vbody = convert_exp f.body}

let interp (Program defs : program) : int =
  let _ = init_gc_globals () in
  defs
  |> List.map (fun (Def (Label name, f)) -> (name, convert_fun f))
  |> make_initial_env |> run_main_function
