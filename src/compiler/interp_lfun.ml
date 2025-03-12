open Support.Utils
open Types
open Interp
open Lfun

(* ----------------------------------------------------------------------
 * Definitional interpreter.
 * ---------------------------------------------------------------------- *)

(* This interpreter is written in "function-on-environment" style.
   The expression constructors are converted to `fexp` functions,
   i.e. functions that take an environment and return a value.
   The reason for this is because these functions can be reused
   in later interpreters when only a small number of constructors change.
   This greatly reduces the length of many of the subsequent interpreters.
   (It's also a much more efficient way to interpret the language,
   though that isn't a particularly important goal here.) *)

let void_exp _ = `VoidV

let bool_exp b _ = `BoolV b

let int_exp i _ = `IntV i

let var_exp v env =
  let loc =
    Env.find_or_fail v env ~err_msg:(Printf.sprintf "variable (%s) not found" v)
  in
  !loc

let prim_exp op args env =
  let args' = List.map (fun e -> e env) args in
  (interp_core_op_simple op args' :> value)

let set_bang_exp var e env =
  let v = e env in
  let loc =
    Env.find_or_fail var env
      ~err_msg:(Printf.sprintf "set! : variable (%s) not found" var)
  in
  loc := v ;
  `VoidV

let begin_exp es e env =
  List.iter (fun e -> ignore (e env)) es ;
  e env

let if_exp e1 e2 e3 env =
  match e1 env with
  | `BoolV b -> if b then e2 env else e3 env
  | _ -> failwith "if : wrong test expression type"

let and_exp arg1 arg2 env =
  match arg1 env with
  | `BoolV false -> `BoolV false
  | `BoolV true -> (
    let a2 = arg2 env in
    match a2 with
    | `BoolV _ -> a2
    | _ -> failwith "and : wrong types" )
  | _ -> failwith "and : wrong types"

let or_exp arg1 arg2 env =
  match arg1 env with
  | `BoolV true -> `BoolV true
  | `BoolV false -> (
    let a2 = arg2 env in
    match a2 with
    | `BoolV _ -> a2
    | _ -> failwith "or : wrong types" )
  | _ -> failwith "or : wrong types"

let while_exp e_test e_body env =
  let rec iter test body =
    match test env with
    | `BoolV b ->
      if b then (
        ignore (body env) ;
        iter test body )
      else `VoidV
    | _ -> failwith "while : wrong test expression type"
  in
  iter e_test e_body

let let_exp v e1 e2 env =
  let new_env = Env.add v (ref (e1 env)) env in
  e2 new_env

let vec_exp es _ env =
  (* Note that `List.map` traverses the list from left to right,
     which is what we need. *)
  let vs = List.map (fun e -> e env) es in
  `VecV (Array.of_list vs)

let vec_len_exp e env =
  match e env with
  | `VecV vs -> `IntV (Array.length vs)
  | _ -> failwith "vector-length : wrong type"

let vec_ref_exp e i env =
  match e env with
  | `VecV vs ->
    if i >= 0 && i < Array.length vs then vs.(i)
    else failwith "vector-ref : index out of range"
  | _ -> failwith "vector-ref : wrong types"

let vec_set_exp e1 i e2 env =
  let vec = e1 env in
  let v = e2 env in
  match vec with
  | `VecV vs ->
    if i >= 0 && i < Array.length vs then (
      vs.(i) <- v ;
      `VoidV )
    else failwith "vector-set! : index out of range"
  | _ -> failwith "vector-set! : wrong types"

let rec apply_exp e es env =
  match e env with
  | `FunV (f, e) -> (
    match !e with
    | None -> failwith "apply_exp: function value has no environment"
    | Some env' ->
      let args = List.map (fun e -> e env) es in
      apply f args env' )
  | v -> failwithf "apply_exp: applied non-function: (%s)" (string_of_value v)

and apply (f : fun_value) (args : value list) (env : env_t) =
  let vars = List.map fst f.vargs in
  let arglist =
    try List.combine vars args with
    | Invalid_argument _ ->
      (* list length mismatch *)
      failwithf "apply: expected (%d) arguments but got (%d)" (List.length vars)
        (List.length args)
  in
  (* Create the function body environment, including the bindings
     between arguments and formal parameters.
     The environment binds names to value refs, so we wrap each value
     in a `ref`. *)
  let env' = List.fold_left (fun e (v, a) -> Env.add v (ref a) e) env arglist in
  f.vbody env'

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
  | And (e1, e2) -> and_exp (conv e1) (conv e2)
  | Or (e1, e2) -> or_exp (conv e1) (conv e2)
  | While (e1, e2) -> while_exp (conv e1) (conv e2)
  | Let (v, e1, e2) -> let_exp v (conv e1) (conv e2)
  | Vec (es, topt) -> vec_exp (map_conv es) topt
  | VecLen e -> vec_len_exp (conv e)
  | VecRef (e, i) -> vec_ref_exp (conv e) i
  | VecSet (e1, i, e2) -> vec_set_exp (conv e1) i (conv e2)
  | Apply (e, es) -> apply_exp (conv e) (map_conv es)

let convert_fun (f : fun_contents) : fun_value =
  {vargs = f.args; vret = f.ret; vbody = convert_exp f.body}

(* Make the initial environment, containing only functions. *)
let make_initial_env (defs : (var * fun_value) list) : env_t =
  (* Create function values from defs, using dummy environments. *)
  let env' =
    List.fold_left
      (fun e (name, f) -> Env.add name (ref (`FunV (f, ref None))) e)
      Env.empty defs
  in
  (* Update the function environments to include all defined functions. *)
  let def_names = List.map fst defs in
  let _ =
    List.iter
      (fun name ->
        let fun_ref = Env.find name env' in
        match !fun_ref with
        | `FunV (_, e) -> e := Some env'
        | _ ->
          failwithf
            "make_initial_env: non-function value bound to function (%s)" name )
      def_names
  in
  env'

let interp (Program (defs, exp) : program) : int =
  defs
  |> List.map (fun (Def (name, f)) -> (name, convert_fun f))
  |> make_initial_env |> convert_exp exp
  |> expect_int ~err_msg:"interp: return value" ~to_string:string_of_value
