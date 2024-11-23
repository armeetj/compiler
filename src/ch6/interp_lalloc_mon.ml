open Types
open Interp
open Interp_utils
open Interp_ltup
open Interp_lalloc
open Lalloc_mon

let convert_atm (a : atm) : fexp =
  match a with
  | Void ->
      void_exp
  | Bool b ->
      bool_exp b
  | Int i ->
      int_exp i
  | Var v ->
      var_exp v

let rec convert_exp (e : exp) : fexp =
  let conv = convert_exp in
  let map_conv = List.map conv in
  let aconv = convert_atm in
  let map_aconv = List.map convert_atm in
  match e with
  | Atm a ->
      aconv a
  | Prim (op, args) ->
      prim_exp op (map_aconv args)
  | SetBang (v, e) ->
      set_bang_exp v (conv e)
  | Begin (es, e) ->
      begin_exp (map_conv es) (conv e)
  | If (e1, e2, e3) ->
      if_exp (conv e1) (conv e2) (conv e3)
  | While (e1, e2) ->
      while_exp (conv e1) (conv e2)
  | Let (v, e1, e2) ->
      let_exp v (conv e1) (conv e2)
  | Collect i ->
      collect_exp i
  | Allocate (i, t) ->
      allocate_exp i t
  | GlobalVal v ->
      global_var_exp v
  | VecLen a ->
      vec_len_exp (aconv a)
  | VecRef (a, i) ->
      vec_ref_exp (aconv a) i
  | VecSet (a1, i, a2) ->
      vec_set_exp (aconv a1) i (aconv a2)

let interp (Program exp : program) : int =
  let _ = init_gc_globals () in
  let initial_env = Env.empty in
  let result = convert_exp exp initial_env in
  expect_int ~err_msg:"interp: return value" result
