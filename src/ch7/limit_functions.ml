open Support.Utils
open Types
open Lfun_ref

let fresh = make_gensym ()

(* Function to create new names for the new tuple variables. *)
let new_tup_var () = fresh ~base:"$tup" ~sep:"."

(* Global set of function names whose argument counts have changed. *)
let limited_names = ref VarSet.empty

(* Record type containing information about extra arguments. *)
type extra_args = {
  tup_name : var;           (* name of extra argument tuple *)
  argc     : int;           (* number of extra arguments *)
  argnums  : int VarMap.t;  (* tuple index of extra arguments *)
}

(* An `extra_args` record returned when there are no extra arguments. *)
let no_extra_args = { tup_name = ""; argc = 0; argnums = VarMap.empty }

(* Convert types to new function type representation,
   with a maximum of 6 arguments. 
   This affects all types that are function types
   or can include function types (like vectors). *)
let rec limit_type (t : ty) : ty =
  failwith "TODO"

(* Change the argument declaration of a function
   to take extra arguments into account. *)
let limit_args (ex : extra_args) (args : (var * ty) list) : (var * ty) list =
  failwith "TODO"

(* Change the body of a function to account for the extra arguments
   of the function. Variable references for extra arguments
   must be changed to vector references. `Apply` expressions
   also must be changed if there are more than 6 arguments,
   which involves creating a new vector.
   Note: You don't need to specify the type of this vector here;
   that will be handled in the next type checking pass.
 *)
let limit_functions_exp (ex : extra_args) (e : exp) : exp =
  failwith "TODO"

(* Create the `extra_args` record from the argument list. *)
let get_extra_args (args : (var * ty) list) : extra_args * bool =
  failwith "TODO"

let limit_function_def (d : def) : def =
  let (Def (name, fcont)) = d in
  let { args; ret; body } = fcont in
  let (ex, has_extra_args) = get_extra_args args in
  let _ =
    if has_extra_args then
      limited_names :=
        VarSet.add (string_of_label name) !limited_names
  in
  let body' = limit_functions_exp ex body in
  let args' = limit_args ex args in
  let ret'  = limit_type ret in
  let fcont' = { args = args'; ret = ret'; body = body' } in
    Def (name, fcont')

(* Update all `FunRef` arities for functions that have been limited. *)
let fix_fun_refs (d : def) : def =
  failwith "TODO"

(* Validation function.
   - Check that no function definition has more than 6 arguments.
   - Check that FunRef arities are <= 6.
   - Check that Apply expressions have no more than 6 arguments. *)
let validate_def (d : def) : unit =
  let (Def (_, fcont)) = d in
  let { args; body; _ } = fcont in
  let conv (e : exp) : exp =
    match e with
      | FunRef (_, i) ->
          if i < 0 || i > 6 then
            failwithf "validate_def: invalid FunRef arity: %d" i
          else
            e
      | Apply (_, es) ->
          if List.length es > 6 then
            failwithf "validate_def: too many arguments to Apply: %d"
              (List.length es)
          else
            e
      | _ -> e
  in
    begin
      assert (List.length args <= 6);
      ignore (convert_exp conv body)
    end

let limit_functions (Program defs) =
  let _ = limited_names := VarSet.empty in
  let defs'  = List.map limit_function_def defs in
  let defs'' = List.map fix_fun_refs defs' in
  let _ = List.iter validate_def defs'' in
    Program defs''

