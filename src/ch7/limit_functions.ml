open Support.Utils
open Types
open Lfun_ref

let fresh = make_gensym ()

(* Function to create new names for the new tuple variables. *)
let new_tup_var () = fresh ~base:"$tup" ~sep:"."

(* Global set of function names whose argument counts have changed. *)
let limited_names = ref VarSet.empty

(* Record type containing information about extra arguments. *)
type extra_args =
  { tup_name : var (* name of extra argument tuple *)
  ; argc : int (* number of extra arguments *)
  ; argnums : int VarMap.t (* tuple index of extra arguments *) }

(* An `extra_args` record returned when there are no extra arguments. *)
let no_extra_args = {tup_name = ""; argc = 0; argnums = VarMap.empty}

(* Convert types to new function type representation,
   with a maximum of 6 arguments.
   This affects all types that are function types
   or can include function types (like vectors). *)
let rec limit_type (t : ty) : ty =
  match t with
  | Unit
   |Boolean
   |Integer ->
    t
  (* a Vector can have a nested Function type, which must be processed *)
  | Vector ty_arr -> Vector (Array.map limit_type ty_arr)
  | Function (arg_tys, ret_ty) ->
    let l = List.length arg_tys in
    if l <= 6 then Function (List.map limit_type arg_tys, limit_type ret_ty)
    else
      let aux = List.map limit_type in
      let head_lst = aux (take 5 arg_tys) in
      let rest_vector = Vector (Array.of_list (aux (drop 5 arg_tys))) in
      Function (head_lst @ [rest_vector], limit_type ret_ty)

(* Change the argument declaration of a function
   to take extra arguments into account. *)
let limit_args (ex : extra_args) (args : (var * ty) list) : (var * ty) list =
  match List.length args with
  | l when l <= 6 -> List.map (fun (v, ty) -> (v, limit_type ty)) args
  | _ ->
    let aux = List.map (fun (v, ty) -> (v, limit_type ty)) in
    let head = aux (take 5 args) in
    let rest = aux (drop 5 args) in
    let rest = Vector (Array.of_list (List.map snd rest)) in
    head @ [(ex.tup_name, limit_type rest)]

(* Change the body of a function to account for the extra arguments
   of the function. Variable references for extra arguments
   must be changed to vector references. `Apply` expressions
   also must be changed if there are more than 6 arguments,
   which involves creating a new vector.
   Note: You don't need to specify the type of this vector here;
   that will be handled in the next type checking pass.
*)
let limit_functions_exp (ex : extra_args) (e : exp) : exp =
  let fn = function
    (* change var references to vector references if needed *)
    | Var v -> (
      match VarMap.find_opt v ex.argnums with
      | Some i -> VecRef (Var ex.tup_name, i)
      | None -> Var v )
    (* change apply expressions with > 6 args *)
    | Apply (f, args) when List.length args > 6 ->
      let head = take 5 args in
      (* don't specify the type of vector here so just None *)
      let rest_vec = Vec (drop 5 args, None) in
      (* head @ [rest_vec] has len 6 *)
      Apply (f, head @ [rest_vec])
    | e -> e
  in
  convert_exp fn e

(* Create the `extra_args` record from the argument list. *)
let get_extra_args (args : (var * ty) list) : extra_args * bool =
  match List.length args with
  | l when l <= 6 -> (no_extra_args, false)
  | l ->
    (* get name *)
    let tup_name = new_tup_var () in
    let argc = l - 5 in
    let extra_args_enumerated =
      List.mapi (fun i (v, _) -> (v, i)) (drop 5 args)
    in
    let argnums = VarMap.of_list extra_args_enumerated in
    ({tup_name; argc; argnums}, true)

let limit_function_def (d : def) : def =
  let (Def (name, fcont)) = d in
  let {args; ret; body} = fcont in
  let ex, has_extra_args = get_extra_args args in
  let _ =
    if has_extra_args then
      limited_names := VarSet.add (string_of_label name) !limited_names
  in
  let body' = limit_functions_exp ex body in
  let args' = limit_args ex args in
  let ret' = limit_type ret in
  let fcont' = {args = args'; ret = ret'; body = body'} in
  Def (name, fcont')

(* Update all `FunRef` arities for functions that have been limited. *)
let fix_fun_refs (d : def) : def =
  let (Def (l, {args; ret; body})) = d in
  let fn = function
    | FunRef (l, arity) ->
      if VarSet.mem (string_of_label l) !limited_names then FunRef (l, 6)
      else FunRef (l, arity)
    | e -> e
  in
  Def (l, {args; ret; body = convert_exp fn body})

(* Validation function.
   - Check that no function definition has more than 6 arguments.
   - Check that FunRef arities are <= 6.
   - Check that Apply expressions have no more than 6 arguments. *)
let validate_def (d : def) : unit =
  let (Def (_, fcont)) = d in
  let {args; body; _} = fcont in
  let conv (e : exp) : exp =
    match e with
    | FunRef (_, i) ->
      if i < 0 || i > 6 then
        failwithf "validate_def: invalid FunRef arity: %d" i
      else e
    | Apply (_, es) ->
      if List.length es > 6 then
        failwithf "validate_def: too many arguments to Apply: %d"
          (List.length es)
      else e
    | _ -> e
  in
  assert (List.length args <= 6) ;
  ignore (convert_exp conv body)

let limit_functions (Program defs) =
  let _ = limited_names := VarSet.empty in
  let defs' = List.map limit_function_def defs in
  let defs'' = List.map fix_fun_refs defs' in
  let _ = List.iter validate_def defs'' in
  Program defs''
