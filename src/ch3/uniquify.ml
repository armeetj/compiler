open Support
open Support.Utils
open Types
open Lvar

let fresh = Utils.make_gensym ()

let uniquify_exp (e : exp) : exp =
  failwith "TODO"

let validate (e : exp) : unit =
  let rec aux (s : VarSet.t) (e : exp) : VarSet.t  =
    match e with
      | Int _
      | Var _
      | Read -> s
      | Negate e1 -> aux s e1
      | Add (e1, e2)
      | Sub (e1, e2) ->
          let s1 = aux s e1 in
            aux s1 e2
      | Let (v, e1, e2) ->
          if VarSet.mem v s then
            failwithf
              "uniquify: validate: variable %s bound more than once" v
          else
            let s1 = VarSet.add v s in
              List.fold_left aux s1 [e1; e2]
  in
    let _ = aux VarSet.empty e in ()

let uniquify (prog : program) : program =
  let (Program e) = prog in
  let ue = uniquify_exp e in
  let _  = validate ue in
    Program ue
