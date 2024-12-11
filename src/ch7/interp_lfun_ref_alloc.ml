open Support.Utils
open Types
open Type_check
open Interp
open Interp_utils
open Interp_lfun
open Interp_lfun_shrink
open Interp_lfun_ref
open Lfun_ref_alloc

(* ----------------------------------------------------------------------
 * Utility functions.
 * ---------------------------------------------------------------------- *)

(* Generate an "uninitialized" default value for any type.
 * The actual value doesn't matter. *)
let rec default_val (t : ty) : value =
  match t with
    | Unit              -> `VoidV
    | Boolean           -> `BoolV false
    | Integer           -> `IntV 0
    | Vector ts         -> `VecV (Array.map default_val ts)
    | Function (ts, t') ->
      let vars =  (* dummy formal variables: "_0", "_1" etc. *)
        List.map
          (fun i -> "_" ^ string_of_int i)
          (range 0 (List.length ts))
      in
      let vargs = List.combine vars ts in
      let vret  = t' in
      (* The body is a dummy body and isn't properly typed,
         but this doesn't matter when interpreting
         since the function itself is just a dummy value
         which will be overwritten in the vector
         of which it's a component. *)
      let vbody = fun _ -> `VoidV in
      let env  = ref None in
        `FunV ({ vargs; vret; vbody }, env)

(* ----------------------------------------------------------------------
 * Definitional interpreter.
 * ---------------------------------------------------------------------- *)

let collect_exp i _ =
  begin
    collect i;
    `VoidV
  end

let allocate_exp i t _ =
  match t with
    | Vector ts ->
      (* Return an "uninitialized" value of a vector type. *)
      if Array.length ts <> i then
        failwithf "interp_exp: malformed `Allocate` case"
      else
        (* Compute the allocation size in bytes,
           which is (8 * (i + 1))
           i.e. 8 bytes for each slot + 8 bytes for the tag.
           Allocate the memory and return a vector of uninitialized values. *)
        let size = 8 * (i + 1) in
          begin
            allocate size;
            `VecV (Array.map default_val ts)
          end
    
    | _ ->
      failwithf "interp_exp: can't allocate type (%s)" (string_of_ty t)

let global_var_exp v _ =
  begin
    match v with
      | "free_ptr"      -> `IntV !free_ptr
      | "fromspace_end" -> `IntV !fromspace_end
      | _ -> failwithf "interp_exp: unknown global variable (%s)" v
  end

let rec convert_exp (e : exp) : fexp =
  let conv = convert_exp in
  let map_conv = List.map conv in
    match e with
      | Void               -> void_exp
      | Bool b             -> bool_exp b
      | Int i              -> int_exp i
      | Var v              -> var_exp v
      | FunRef (f, i)      -> fun_ref_exp f i
      | Prim (op, args)    -> prim_exp op (map_conv args)
      | SetBang (v, e)     -> set_bang_exp v (conv e)
      | Begin (es, e)      -> begin_exp (map_conv es) (conv e)
      | If (e1, e2, e3)    -> if_exp (conv e1) (conv e2) (conv e3)
      | While (e1, e2)     -> while_exp (conv e1) (conv e2)
      | Let (v, e1, e2)    -> let_exp v (conv e1) (conv e2)
      | Collect i          -> collect_exp i
      | Allocate (i, t)    -> allocate_exp i t
      | GlobalVal v        -> global_var_exp v
      | VecLen e           -> vec_len_exp (conv e)
      | VecRef (e, i)      -> vec_ref_exp (conv e) i
      | VecSet (e1, i, e2) -> vec_set_exp (conv e1) i (conv e2)
      | Apply (e, es)      -> apply_exp (conv e) (map_conv es)

let convert_fun (f : fun_contents) : fun_value =
  {
    vargs = f.args;
    vret  = f.ret;
    vbody = convert_exp f.body
  }

let interp (Program defs : program) : int =
  let _ = init_gc_globals () in
    defs
      |> List.map (fun (Def (Label name, f)) -> (name, convert_fun f))
      |> make_initial_env
      |> run_main_function

