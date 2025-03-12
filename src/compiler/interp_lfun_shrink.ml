open Types
open Interp
open Interp_lfun
open Lfun_shrink

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
  | While (e1, e2) -> while_exp (conv e1) (conv e2)
  | Let (v, e1, e2) -> let_exp v (conv e1) (conv e2)
  | Vec (es, topt) -> vec_exp (map_conv es) topt
  | VecLen e -> vec_len_exp (conv e)
  | VecRef (e, i) -> vec_ref_exp (conv e) i
  | VecSet (e1, i, e2) -> vec_set_exp (conv e1) i (conv e2)
  | Apply (e, es) -> apply_exp (conv e) (map_conv es)

let convert_fun (f : fun_contents) : fun_value =
  {vargs = f.args; vret = f.ret; vbody = convert_exp f.body}

let run_main_function (env : env_t) =
  match Env.find_opt "main" env with
  | None -> failwith "no `main` function"
  | Some fun_ref -> (
    match !fun_ref with
    | `FunV ({vbody; _}, env_optref) -> (
      match !env_optref with
      | None ->
        failwith ("run_main_function: " ^ "`main` function has no environment")
      | Some env' ->
        let v = vbody env' in
        expect_int ~err_msg:"run_main_function: return value"
          ~to_string:string_of_value v )
    | _ -> failwith "interp: non-function value bound to function (main)" )

let interp (Program defs : program) : int =
  defs
  |> List.map (fun (Def (name, f)) -> (name, convert_fun f))
  |> make_initial_env |> run_main_function
