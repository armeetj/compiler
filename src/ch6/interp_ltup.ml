open Types
open Interp
open Ltup

(* This interpreter (and most subsequent interpreters)
   are written in "function-on-environment" style.
   The expression constructors are converted to `fexp` functions,
   i.e. functions that take an environment and return a value.
   The reason for this is because these functions can be reused
   in later interpreters when only a small number of constructors change.
   This greatly reduces the length of many of the subsequent interpreters.
   (It's also a much more efficient way to interpret the language,
   though that isn't a particularly important goal here.) *)

let void_exp _ = VoidV

let bool_exp b _ = BoolV b

let int_exp i _ = IntV i

let var_exp v env =
  let loc =
    Env.find_or_fail v env
      ~err_msg:
         (Printf.sprintf
            "variable (%s) not found" v)
  in
    !loc

let prim_exp op args env =
  let args' = List.map (fun e -> e env) args in
    interp_core_op op args'

let set_bang_exp var e env =
  let v = e env in
  let loc =
    Env.find_or_fail var env
      ~err_msg:
         (Printf.sprintf
            "set! : variable (%s) not found" var)
  in
    (loc := v; VoidV)

let begin_exp es e env =
  begin
    List.iter (fun e -> ignore (e env)) es;
    e env
  end

let if_exp e1 e2 e3 env =
  match e1 env with
    | BoolV b -> if b then e2 env else e3 env
    | _ -> failwith "if : wrong test expression type"

let and_exp e1 e2 env =
  match e1 env with
    | BoolV false -> BoolV false
    | BoolV true  ->
        let v2 = e2 env in
          begin
            match v2 with
              | BoolV _ -> v2
              | _ -> failwith "and : wrong types"
          end
    | _ -> failwith "and : wrong types"

let or_exp e1 e2 env =
  match e1 env with
    | BoolV true -> BoolV true
    | BoolV false  ->
        let v2 = e2 env in
          begin
            match v2 with
              | BoolV _ -> v2
              | _ -> failwith "or : wrong types"
          end
    | _ -> failwith "or : wrong types"

let while_exp e_test e_body env =
  let rec iter test body =
    match test env with
      | BoolV b ->
          if b then
            (ignore (body env); iter test body)
          else
            VoidV
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
    VecV (Array.of_list vs)

let vec_len_exp e env =
  match e env with
    | VecV vs -> IntV (Array.length vs)
    | _ -> failwith "vector-length : wrong type"

let vec_ref_exp e i env =
  match e env with
    | VecV vs ->
        if i >= 0 && i < Array.length vs then
          vs.(i)
        else
          failwith "vector-ref : index out of range"
    | _ -> failwith "vector-ref : wrong types"

let vec_set_exp e1 i e2 env =
  let vec = e1 env in
  let v   = e2 env in
    match vec with
      | VecV vs ->
          if i >= 0 && i < Array.length vs then
            (vs.(i) <- v; VoidV)
          else
            failwith "vector-set! : index out of range"
      | _ -> failwith "vector-set! : wrong types"

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
      | And (e1, e2)       -> and_exp (conv e1) (conv e2)
      | Or (e1, e2)        -> or_exp (conv e1) (conv e2)
      | While (e1, e2)     -> while_exp (conv e1) (conv e2)
      | Let (v, e1, e2)    -> let_exp v (conv e1) (conv e2)
      | Vec (es, topt)     -> vec_exp (map_conv es) topt
      | VecLen e           -> vec_len_exp (conv e)
      | VecRef (e, i)      -> vec_ref_exp (conv e) i
      | VecSet (e1, i, e2) -> vec_set_exp (conv e1) i (conv e2)

let interp (Program exp : program) : int =
  let initial_env = Env.empty in
  let result = convert_exp exp initial_env in
    expect_int ~err_msg:"interp: return value" result

