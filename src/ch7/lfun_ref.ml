open Sexplib.Std
open Types

(* ----------------------------------------------------------------------  
 * Types.
 * ---------------------------------------------------------------------- *)

type exp =
  | Void
  | Bool    of bool
  | Int     of int
  | Var     of var
  | FunRef  of label * int
  | Prim    of core_op * exp list
  | SetBang of var * exp
  | Begin   of exp list * exp
  | If      of exp * exp * exp
  | While   of exp * exp
  | Let     of var * exp * exp
  | Vec     of exp list * ty option
  | VecLen  of exp
  | VecRef  of exp * int
  | VecSet  of exp * int * exp
  | Apply   of exp * exp list
[@@deriving sexp]

type fun_contents =
  {
    args : (var * ty) list;
    ret  : ty;
    body : exp;
  }
[@@deriving sexp]

type def = Def of label * fun_contents
[@@deriving sexp]

type program = Program of def list
[@@deriving sexp]

(* ----------------------------------------------------------------------  
 * Utilities.
 * ---------------------------------------------------------------------- *)

(* Convert an expression by applying a function to each subexpression
   and then to the expression as a whole. *)
let rec convert_exp (f : exp -> exp) (e : exp) : exp =
  let aux = convert_exp f in
  let e' =
    match e with
      | Void
      | Bool _
      | Int _
      | Var _
      | FunRef _ -> e

      | Prim (op, es) ->
          let es' = List.map aux es in
            Prim (op, es')

      | SetBang (v, e) ->
          let e' = aux e in
            SetBang (v, e')

      | Begin (es, e) ->
          let es' = List.map aux es in
          let e'  = aux e in
            Begin (es', e')

      | If (e1, e2, e3) ->
          let e1' = aux e1 in
          let e2' = aux e2 in
          let e3' = aux e3 in
            If (e1', e2', e3')

      | While (e1, e2) ->
          let e1' = aux e1 in
          let e2' = aux e2 in
            While (e1', e2')

      | Let (v, e1, e2) ->
          let e1' = aux e1 in
          let e2' = aux e2 in
            Let (v, e1', e2')

      | Vec (es, t) ->
          Vec (List.map aux es, t)

      | VecLen e ->
          VecLen (aux e)

      | VecRef (e, i) ->
          VecRef (aux e, i)

      | VecSet (e1, i, e2) ->
          let e1' = aux e1 in
          let e2' = aux e2 in
            VecSet (e1', i, e2')

      | Apply (e, es) ->
          let e'  = aux e in
          let es' = List.map aux es in
            Apply (e', es')
  in
    f e'

