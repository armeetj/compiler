open Support
open Support.Utils
open Types
open Lfun_shrink

let fresh = Utils.make_gensym ()

let rec uniquify_exp (env : var VarMap.t) (e : exp) : exp =
  failwith "TODO"

let uniquify_def (Def (name, fcont)) =
  let { args; ret; body } = fcont in
  let (names, tys) = List.split args in
  (* We set up the name->name mapping environment here,
     which includes the function argument names. *)
  let names' = List.map (fun n -> fresh ~base:n ~sep:".") names in
  let env = VarMap.of_list (List.combine names names') in
  let args'  = List.combine names' tys in
  let body'  = uniquify_exp env body in
    Def (name, { args = args'; ret; body = body' })

let def_name (Def (name, _)) = name

(* Validation function.
   Make sure that each name is bound only once.
   Also check that all `set!` variables are bound. *)
let validate_exp (s : VarSet.t) (e : exp) : unit =
  let rec aux (s : VarSet.t) (e : exp) : VarSet.t  =
    match e with
      | Void
      | Bool _
      | Int _
      | Var _ -> s
      | Prim (_, es) ->
          List.fold_left aux s es
      | SetBang (v, e) ->
          if not (VarSet.mem v s) then
            failwithf
              "uniquify: validate: unbound variable %s in set! form" v
          else
            aux s e
      | Begin (es, e) ->
          List.fold_left aux s (es @ [e])
      | If (e1, e2, e3) ->
          List.fold_left aux s [e1; e2; e3]
      | While (e1, e2) ->
          List.fold_left aux s [e1; e2]
      | Let (v, e1, e2) ->
          if VarSet.mem v s then
            failwithf
              "uniquify: validate: variable %s bound more than once" v
          else
            let s1 = VarSet.add v s in
              List.fold_left aux s1 [e1; e2]
      | Vec (es, _) ->
          List.fold_left aux s es
      | VecLen e
      | VecRef (e, _) ->
          aux s e
      | VecSet (e1, _, e2) ->
          List.fold_left aux s [e1; e2]
      | Apply (e, es) ->
          List.fold_left aux s (e :: es)
  in
    let _ = aux s e in ()

let validate_def (d : def) : unit =
  let Def (name, fcont) = d in
  let { args; body; _ } = fcont in
  let (names, _) = List.split args in
  let s = VarSet.of_list names in
    if VarSet.cardinal s <> List.length names then
      failwithf
        "uniquify: validate: argument names are not unique for function %s"
        name
    else
      validate_exp s body

let uniquify (Program ds) =
  let names = List.map def_name ds in
    (* We check that there are no repeated function names,
     * including `main`.  We could have done this check before,
     * but it's convenient to do it here, since all function names
     * (including `main`) are at the same level.
     * We do _not_ change these names. *)
    if no_string_repeats names then
      let ds' = List.map uniquify_def ds in
        begin
          List.iter validate_def ds';
          Program ds'
        end
    else
      failwith "uniquify: repeated function names at top level"
