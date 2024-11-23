open Types
open Cvar
module L = Lvar_mon

let convert_atom (a : L.atm) : atm =
  match a with L.Var v -> Var v | L.Int i -> Int i

let convert_exp (e : L.exp) : exp =
  match e with
  | L.Atm a ->
      Atm (convert_atom a)
  | L.Read ->
      Read
  | L.Negate a ->
      Negate (convert_atom a)
  | L.Add (a1, a2) ->
      Add (convert_atom a1, convert_atom a2)
  | L.Sub (a1, a2) ->
      Sub (convert_atom a1, convert_atom a2)
  | L.Let _ ->
      failwith "this should never happen"

(* Convert expressions which are the binding expression of a `let` expression
 * (i.e. in `(let (var <exp1>) <exp2>)` the binding expression is `<exp1>`).
 * These are ultimately converted to assignments.
 * The `tail` is the continuation (what to do after the binding). *)
let rec explicate_assign (e : L.exp) (v : var) (tl : tail) : tail =
  match e with
  | L.Let (v_in, e1, e2) ->
      explicate_assign e1 v_in (explicate_assign e2 v tl)
  | Read | Atm _ | Negate _ | Add _ | Sub _ ->
      let e_conv = convert_exp e in
      Seq (Assign (v, e_conv), tl)

(* Convert expressions in tail position.
 * This includes:
 * 1) any top-level expression
 * 2) any expression at the end of a larger expression
 *    that will be evaluated to give the result of the entire expression
 * Example of (2): the body of a `let`. *)
let rec explicate_tail (e : L.exp) : tail =
  match e with
  | L.Atm a ->
      Return (Atm (convert_atom a))
  | L.Read ->
      Return Read
  | L.Negate a ->
      Return (Negate (convert_atom a))
  | L.Add (a1, a2) ->
      Return (Add (convert_atom a1, convert_atom a2))
  | L.Sub (a1, a2) ->
      Return (Sub (convert_atom a1, convert_atom a2))
  | L.Let (v, e1, e2) ->
      explicate_assign e1 v (explicate_tail e2)

let explicate_control (prog : L.program) : program =
  let (L.Program e) = prog in
  let t = explicate_tail e in
  let p = CProgram (Info {locals_types = []}, [(Label "start", t)]) in
  (* Add type information to the program for later use. *)
  add_type_info p
