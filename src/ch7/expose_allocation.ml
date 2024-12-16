open Support
open Lfun_ref_alloc
module L = Lfun_ref

let fresh = Utils.make_gensym ()

let new_var () = fresh ~base:"$ea" ~sep:"."

let new_void_var () = fresh ~base:"_" ~sep:"."

(* weird formatting, but makes sense, show indent of chained OR cases *)
let is_atom (e : exp) : bool =
  match e with
  | Void
   |Bool _
   |Int _
   |Var _ ->
    true
  | _ -> false

let convert_atom (e : exp) : [> `Atom of exp | `VarExp of string * exp] =
  match e with
  | _ when is_atom e -> `Atom e
  | _ -> `VarExp (new_var (), e)

let rec expose_allocation_exp (e : L.exp) : exp =
  match e with
  | L.Vec (_, None) -> failwith "[ea:expose_allocation_exp] Vec should be typed"
  | L.Vec (es, Some ty) ->
    (* look for vectors at any point *)
    convert_vec (List.map expose_allocation_exp es) ty
  | L.Bool b -> Bool b
  | L.Var v -> Var v
  | L.Int i -> Int i
  | L.Void -> Void
  | L.Prim (op, es) -> Prim (op, List.map expose_allocation_exp es)
  | L.SetBang (v, e) -> SetBang (v, expose_allocation_exp e)
  | L.Begin (es, e) ->
    let es = List.map expose_allocation_exp es in
    let e = expose_allocation_exp e in
    Begin (es, e)
  | L.If (e1, e2, e3) ->
    let e1 = expose_allocation_exp e1 in
    let e2 = expose_allocation_exp e2 in
    let e3 = expose_allocation_exp e3 in
    If (e1, e2, e3)
  | L.While (cond, body) ->
    let cond = expose_allocation_exp cond in
    let body = expose_allocation_exp body in
    While (cond, body)
  | L.Let (v, e1, e2) ->
    let e1 = expose_allocation_exp e1 in
    let e2 = expose_allocation_exp e2 in
    Let (v, e1, e2)
  | L.VecLen e -> VecLen (expose_allocation_exp e)
  | L.VecRef (e, idx) -> VecRef (expose_allocation_exp e, idx)
  | L.VecSet (e1, idx, e2) ->
    let e1 = expose_allocation_exp e1 in
    let e2 = expose_allocation_exp e2 in
    VecSet (e1, idx, e2)
  | L.FunRef (l, idx) -> FunRef (l, idx)
  | L.Apply (f, args) ->
    Apply (expose_allocation_exp f, List.map expose_allocation_exp args)

and convert_vec (es : exp list) (ty : Types.ty) : exp =
  (* 1/2 - recurse on all subexps es and generate fresh names *)
  let tagged_es = List.map convert_atom es in
  (* 3 - generate fresh name for result vector *)
  let vector_name = new_var () in
  let vector_var = Var vector_name in
  (* 4 - generate the if expr *)
  let len = List.length es in
  let nbytes = (len + 1) * 8 in
  let if_cond =
    Prim
      ( `Lt
      , [ Prim (`Add, [GlobalVal "free_ptr"; Int nbytes])
        ; GlobalVal "fromspace_end" ] )
  in
  let if_then = Void in
  let if_else = Collect nbytes in
  let if_exp = If (if_cond, if_then, if_else) in
  (* 5/6 - generate all !vector-set expressions and wrapping _ let's *)
  let enumerated_tagged_es = List.mapi (fun i e -> (i, e)) tagged_es in
  let vector_set_es =
    List.fold_right
      (fun (i, e) acc ->
        match e with
        | `Atom e -> Let (new_void_var (), VecSet (vector_var, i, e), acc)
        | `VarExp (v, _) ->
          Let (new_void_var (), VecSet (vector_var, i, Var v), acc) )
      enumerated_tagged_es vector_var
  in
  (* 8 - put it all together *)
  let inside =
    Let
      ( new_void_var ()
      , if_exp
      , Let (vector_name, Allocate (len, ty), vector_set_es) )
  in
  (* 7 - generate the outermost lets,
     the order is weird here 8 before 7 because we have to build the outer lets
     wrapped around the inside (step 8) *)
  let outer_lets =
    List.fold_right
      (fun e acc ->
        match e with
        | `Atom _ -> acc
        | `VarExp (v, e) -> Let (v, e, acc) )
      tagged_es inside
  in
  outer_lets

let expose_allocation_def (ldef : L.def) =
  let (Def (name, {args; ret; body})) = ldef in
  let body' = expose_allocation_exp body in
  let fcont' = {args; ret; body = body'} in
  Def (name, fcont')

let expose_allocation (L.Program ds) =
  Program (List.map expose_allocation_def ds)
