open Support
open Support.Utils
open Types
open Lfun_shrink

let fresh = Utils.make_gensym ()

let uniquify_exp (env : var VarMap.t) (e : exp) : exp =
  let rec un_helper e map =
    match e with
    | Let (sym, val_exp, res_exp) ->
      let un_bind_exp = un_helper val_exp map in
      let un_sym = fresh ~base:sym ~sep:"." in
      let nested_map = VarMap.add sym un_sym map in
      let un_body_exp = un_helper res_exp nested_map in
      Let (un_sym, un_bind_exp, un_body_exp)
    | Bool b -> Bool b
    | Int i -> Int i
    | Var sym ->
      if VarMap.mem sym map then Var (VarMap.find sym map) else Var sym
    | Prim (op, exp_lst) ->
      let new_exp_lst = List.map (fun e -> un_helper e map) exp_lst in
      Prim (op, new_exp_lst)
    | Apply (e, el) ->
      let new_el = List.map (fun e -> un_helper e map) el in
      Apply (un_helper e map, new_el)
    | If (if_cond, if_then, if_else) ->
      If (un_helper if_cond map, un_helper if_then map, un_helper if_else map)
    | Void -> Void
    | SetBang (var, exp) ->
      if VarMap.mem var map then SetBang (VarMap.find var map, un_helper exp map)
      else SetBang (var, un_helper exp map)
    | Begin (exp_lst, exp) ->
      let new_exp_lst = List.map (fun e -> un_helper e map) exp_lst in
      Begin (new_exp_lst, un_helper exp map)
    | While (exp1, exp2) -> While (un_helper exp1 map, un_helper exp2 map)
    | Vec (exp_lst, ty) ->
      let new_exp_lst = List.map (fun e -> un_helper e map) exp_lst in
      Vec (new_exp_lst, ty)
    | VecLen exp -> VecLen (un_helper exp map)
    | VecSet (exp1, i, exp2) ->
      let new_exp1 = un_helper exp1 map in
      let new_exp2 = un_helper exp2 map in
      VecSet (new_exp1, i, new_exp2)
    | VecRef (exp, i) -> VecRef (un_helper exp map, i)
  in
  un_helper e env

let uniquify_def (Def (name, fcont)) =
  let {args; ret; body} = fcont in
  let names, tys = List.split args in
  (* We set up the name->name mapping environment here,
     which includes the function argument names. *)
  let names' = List.map (fun n -> fresh ~base:n ~sep:".") names in
  let env = VarMap.of_list (List.combine names names') in
  let args' = List.combine names' tys in
  let body' = uniquify_exp env body in
  Def (name, {args = args'; ret; body = body'})

let def_name (Def (name, _)) = name

(* Validation function.
   Make sure that each name is bound only once.
   Also check that all `set!` variables are bound. *)
let validate_exp (s : VarSet.t) (e : exp) : unit =
  let rec aux (s : VarSet.t) (e : exp) : VarSet.t =
    match e with
    | Void
     |Bool _
     |Int _
     |Var _ ->
      s
    | Prim (_, es) -> List.fold_left aux s es
    | SetBang (v, e) ->
      if not (VarSet.mem v s) then
        failwithf "uniquify: validate: unbound variable %s in set! form" v
      else aux s e
    | Begin (es, e) -> List.fold_left aux s (es @ [e])
    | If (e1, e2, e3) -> List.fold_left aux s [e1; e2; e3]
    | While (e1, e2) -> List.fold_left aux s [e1; e2]
    | Let (v, e1, e2) ->
      if VarSet.mem v s then
        failwithf "uniquify: validate: variable %s bound more than once" v
      else
        let s1 = VarSet.add v s in
        List.fold_left aux s1 [e1; e2]
    | Vec (es, _) -> List.fold_left aux s es
    | VecLen e
     |VecRef (e, _) ->
      aux s e
    | VecSet (e1, _, e2) -> List.fold_left aux s [e1; e2]
    | Apply (e, es) -> List.fold_left aux s (e :: es)
  in
  let _ = aux s e in
  ()

let validate_def (d : def) : unit =
  let (Def (name, fcont)) = d in
  let {args; body; _} = fcont in
  let names, _ = List.split args in
  let s = VarSet.of_list names in
  if VarSet.cardinal s <> List.length names then
    failwithf
      "uniquify: validate: argument names are not unique for function %s" name
  else validate_exp s body

let uniquify (Program ds) =
  let names = List.map def_name ds in
  (* We check that there are no repeated function names,
   * including `main`.  We could have done this check before,
   * but it's convenient to do it here, since all function names
   * (including `main`) are at the same level.
   * We do _not_ change these names. *)
  if no_string_repeats names then (
    let ds' = List.map uniquify_def ds in
    List.iter validate_def ds' ; Program ds' )
  else failwith "uniquify: repeated function names at top level"
