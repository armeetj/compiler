open Types
open Cvar

module L = Lvar_mon

let convert_atom (a : L.atm) : atm =
  failwith "TODO"

let convert_exp (e : L.exp) : exp =
  failwith "TODO"

(* Convert expressions which are the binding expression of a `let` expression
 * (i.e. in `(let (var <exp1>) <exp2>)` the binding expression is `<exp1>`).
 * These are ultimately converted to assignments.
 * The `tail` is the continuation (what to do after the binding). *)
let rec explicate_assign (e : L.exp) (v : var) (tl : tail) : tail =
  failwith "TODO"

(* Convert expressions in tail position.
 * This includes:
 * 1) any top-level expression
 * 2) any expression at the end of a larger expression
 *    that will be evaluated to give the result of the entire expression
 * Example of (2): the body of a `let`. *)
let rec explicate_tail (e : L.exp) : tail =
  failwith "TODO"

let explicate_control (prog : L.program) : program =
  let (L.Program e) = prog in
  let t = explicate_tail e in
  let p = CProgram (Info { locals_types = [] }, [(Label "start", t)]) in
    (* Add type information to the program for later use. *)
    add_type_info p
