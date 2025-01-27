open Types
open Lalloc_get
module L = Lalloc
module S = VarSet

let collect_set_vars (e : L.exp) : S.t =
  let rec helper s_acc e =
    match e with
    | L.Prim (_, exp_lst) -> List.fold_left helper s_acc exp_lst
    | L.SetBang (v, exp) -> S.add v (helper s_acc exp)
    | L.Begin (exp_lst, exp) ->
      let s_acc_after = helper s_acc exp in
      List.fold_left helper s_acc_after exp_lst
    | L.If (e1, e2, e3) ->
      let st1 = helper s_acc e1 in
      let st2 = helper st1 e2 in
      helper st2 e3
    | L.While (e1, e2) ->
      let st1 = helper s_acc e1 in
      helper st1 e2
    | L.Let (_, e1, e2) ->
      let st1 = helper s_acc e1 in
      helper st1 e2
    | _ -> s_acc
  in
  helper S.empty e

let rec uncover_get_exp (s : S.t) (e : L.exp) : exp =
  match e with
  | L.Var v -> if S.mem v s then GetBang v else Var v
  | L.Prim (c_op, exp_lst) -> Prim (c_op, List.map (uncover_get_exp s) exp_lst)
  | L.SetBang (c_op, exp) -> SetBang (c_op, uncover_get_exp s exp)
  | L.Begin (exp_lst, exp) ->
    Begin (List.map (uncover_get_exp s) exp_lst, uncover_get_exp s exp)
  | L.If (e1, e2, e3) ->
    If (uncover_get_exp s e1, uncover_get_exp s e2, uncover_get_exp s e3)
  | L.While (e1, e2) -> While (uncover_get_exp s e1, uncover_get_exp s e2)
  | L.Let (v, e1, e2) -> Let (v, uncover_get_exp s e1, uncover_get_exp s e2)
  | L.Void -> Void
  | L.Bool b -> Bool b
  | L.Int i -> Int i
  | Collect i -> Collect i
  | Allocate (i, ty) -> Allocate (i, ty)
  | GlobalVal v -> GlobalVal v
  | VecLen exp -> VecLen (uncover_get_exp s exp)
  | VecRef (exp, i) -> VecRef (uncover_get_exp s exp, i)
  | VecSet (exp1, i, exp2) ->
    VecSet (uncover_get_exp s exp1, i, uncover_get_exp s exp2)

let uncover_get (prog : L.program) : program =
  let (L.Program e) = prog in
  let set_vars = collect_set_vars e in
  Program (uncover_get_exp set_vars e)
