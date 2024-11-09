open Types
open Interp
open Lif

(* This interpreter (and most subsequent interpreters)
   are written in "function-on-environment" style.
   The expression constructors are converted to `fexp` functions,
   i.e. functions that take an environment and return a value.
   The reason for this is because these functions can be reused
   in later interpreters when only a small number of constructors change.
   This greatly reduces the length of many of the subsequent interpreters.
   (It's also a much more efficient way to interpret the language,
   though that isn't a particularly important goal here.) *)

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

let let_exp v e1 e2 env =
  let new_env = Env.add v (ref (e1 env)) env in
    e2 new_env

let rec convert_exp (e : exp) : fexp =
  let conv = convert_exp in
  let map_conv = List.map conv in
    match e with
      | Bool b          -> bool_exp b
      | Int i           -> int_exp i
      | Var v           -> var_exp v
      | Prim (op, args) -> prim_exp op (map_conv args)
      | If (e1, e2, e3) -> if_exp (conv e1) (conv e2) (conv e3)
      | And (e1, e2)    -> and_exp (conv e1) (conv e2)
      | Or (e1, e2)     -> or_exp (conv e1) (conv e2)
      | Let (v, e1, e2) -> let_exp v (conv e1) (conv e2)

let interp (Program exp : program) : int =
  let initial_env = Env.empty in
  let result = convert_exp exp initial_env in
    expect_int ~err_msg:"interp: return value" result

