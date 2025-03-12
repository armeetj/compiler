open Support.Utils
open Lfun
open Types
open Type_check

(* This type checker adds type annotations to `Vector` expressions,
   so it returns the updated expression as well as the type. *)
let rec type_check_exp (ty_env : ty_env_t) (e : exp) : exp * ty =
  match e with
  | Void -> (e, Unit)
  | Bool _ -> (e, Boolean)
  | Int _ -> (e, Integer)
  | Var v ->
    let t =
      Env.find_or v ty_env ~f:(fun () ->
        ty_err_simple ("unbound variable: " ^ v) )
    in
    (e, t)
  | Prim (op, es) ->
    let es', arg_tys = List.split (List.map (type_check_exp ty_env) es) in
    let t = type_check_op op arg_tys in
    (Prim (op, es'), t)
  | SetBang (v, e) ->
    let t =
      Env.find_or v ty_env ~f:(fun () ->
        ty_err_simple ("set! : unbound variable: " ^ v) )
    in
    let e', t' = type_check_exp ty_env e in
    if not (ty_equal t t') then ty_err "set!" ~expected:t ~got:t'
    else (SetBang (v, e'), Unit)
  | Begin (es, e) ->
    let es', _ = List.split (List.map (type_check_exp ty_env) es) in
    let e', t = type_check_exp ty_env e in
    (Begin (es', e'), t)
  | If (e1, e2, e3) ->
    let e1', t1 = type_check_exp ty_env e1 in
    let e2', t2 = type_check_exp ty_env e2 in
    let e3', t3 = type_check_exp ty_env e3 in
    if not (ty_equal t1 Boolean) then
      ty_err "if test expression" ~expected:Boolean ~got:t1
    else if not (ty_equal t2 t3) then
      ty_err "if else clause" ~expected:t2 ~got:t3
    else (If (e1', e2', e3'), t2)
  | And (e1, e2) ->
    let e1', t1 = type_check_exp ty_env e1 in
    let e2', t2 = type_check_exp ty_env e2 in
    if not (ty_equal t1 Boolean) then
      ty_err "and first expression" ~expected:Boolean ~got:t1
    else if not (ty_equal t2 Boolean) then
      ty_err "and second expression" ~expected:Boolean ~got:t1
    else (And (e1', e2'), Boolean)
  | Or (e1, e2) ->
    let e1', t1 = type_check_exp ty_env e1 in
    let e2', t2 = type_check_exp ty_env e2 in
    if not (ty_equal t1 Boolean) then
      ty_err "or first expression" ~expected:Boolean ~got:t1
    else if not (ty_equal t2 Boolean) then
      ty_err "or second expression" ~expected:Boolean ~got:t1
    else (Or (e1', e2'), Boolean)
  | While (e1, e2) ->
    let e1', t1 = type_check_exp ty_env e1 in
    let e2', t2 = type_check_exp ty_env e2 in
    if not (ty_equal t1 Boolean) then
      ty_err "while test expression" ~expected:Boolean ~got:t1
    else if not (ty_equal t2 Unit) then
      ty_err "if else clause" ~expected:Unit ~got:t2
    else (While (e1', e2'), Unit)
  | Let (v, e1, e2) ->
    let e1', t1 = type_check_exp ty_env e1 in
    let ty_env' = Env.add v t1 ty_env in
    let e2', t2 = type_check_exp ty_env' e2 in
    (Let (v, e1', e2'), t2)
  | Vec (es, _) ->
    let len = List.length es in
    if len > 50 then
      failwithf "type_check_exp: vector length (%d) is too long (maximum 50)"
        len
    else
      let es', ts = List.split (List.map (type_check_exp ty_env) es) in
      let t = Vector (Array.of_list ts) in
      (* Add type annotation to vector. *)
      (Vec (es', Some t), t)
  | VecLen e -> (
    let e', t = type_check_exp ty_env e in
    match t with
    | Vector _ -> (VecLen e', Integer)
    | t ->
      ty_err_simple
      @@ Printf.sprintf "type error: vector-length : expected a vector, got: %s"
           (string_of_ty t) )
  | VecRef (e, i) -> (
    let e', t = type_check_exp ty_env e in
    match t with
    | Vector ts ->
      let len = Array.length ts in
      if i >= 0 && i < len then (VecRef (e', i), ts.(i))
      else
        ty_err_simple
        @@ Printf.sprintf "type error: vector-ref : index %d out of range" i
    | t ->
      ty_err_simple
      @@ Printf.sprintf "type error: vector-ref : expected a vector, got: %s"
           (string_of_ty t) )
  | VecSet (e1, i, e2) -> (
    let e1', t1 = type_check_exp ty_env e1 in
    let e2', t2 = type_check_exp ty_env e2 in
    match t1 with
    | Vector ts ->
      let len = Array.length ts in
      if i >= 0 && i < len then
        if ty_equal ts.(i) t2 then (VecSet (e1', i, e2'), Unit)
        else
          let msg = Printf.sprintf "vector-set!, index %d" i in
          ty_err msg ~expected:ts.(i) ~got:t2
      else
        ty_err_simple
        @@ Printf.sprintf "type error: vector-set! : index %d out of range" i
    | t ->
      ty_err_simple
      @@ Printf.sprintf "type error: vector-set! : expected a vector, got: %s"
           (string_of_ty t) )
  | Apply (e, es) -> (
    let e', t = type_check_exp ty_env e in
    let es', ts = List.split (List.map (type_check_exp ty_env) es) in
    match t with
    | Function (ts', t') ->
      if ty_lists_equal ts ts' then (Apply (e', es'), t')
      else
        ty_err_simple
        @@ Printf.sprintf
             ( "type error: apply : " ^^ "invalid function argument types; "
             ^^ "expected (%s) but got (%s)" )
             (string_of_ty_list ts') (string_of_ty_list ts)
    | _ ->
      ty_err_simple
      @@ Printf.sprintf "type error: apply : expected function type, got (%s)"
           (string_of_ty t) )

let type_check_def (ty_env : ty_env_t) (d : def) : def =
  let (Def (v, fc)) = d in
  (* Add argument types to local type environment. *)
  let ty_env' =
    List.fold_left (fun env (v, t) -> Env.add v t env) ty_env fc.args
  in
  let body', ret_ty = type_check_exp ty_env' fc.body in
  if ty_equal ret_ty fc.ret then Def (v, {fc with body = body'})
  else
    ty_err
      (Printf.sprintf "type_check_def: (%s)" v)
      ~expected:fc.ret ~got:ret_ty

let ty_of_fun_contents name {args; ret; _} =
  let formals, ts = List.split args in
  if no_string_repeats formals then Function (ts, ret)
  else
    let formals_string = String.concat " " formals in
    failwithf "lfun: repeated formal arguments in function %s: (%s)" name
      formals_string

let type_check_def_decl (d : def) : var * ty =
  let (Def (v, fv)) = d in
  let f_ty = ty_of_fun_contents v fv in
  (v, f_ty)

let type_check (prog : program) : program =
  let (Program (defs, e)) = prog in
  (* Create a top-level type environment
     from the global function declarations. *)
  let ty_env =
    List.fold_left
      (fun env d ->
        let v, f_ty = type_check_def_decl d in
        Env.add v f_ty env )
      empty_ty_env defs
  in
  (* Type check the definitions,
     modifying them along the way by adding type information to `Vec`s. *)
  let defs' = List.map (type_check_def ty_env) defs in
  (* Type check the final expression. *)
  match type_check_exp ty_env e with
  | e', Integer -> Program (defs', e')
  | _ -> ty_err_simple "program expression should have type Integer"
