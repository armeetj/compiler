open Support.Utils
open Types
open Ctup
module L = Lalloc_mon

(* Variable to hold gensym function. *)
let fresh = ref (make_gensym ())

(* Variable to hold labeled blocks. *)
let basic_blocks = ref LabelMap.empty
let convert_atom (a : L.atm) : atm = failwith "TODO"
let convert_exp (e : L.exp) : exp = failwith "TODO"

(* Convert expressions which are the binding expression of a `let` expression
 * (i.e. in `(let (var <exp1>) <exp2>)` the binding expression is `<exp1>`).
 * These are ultimately converted to assignments.
 * The `tail` is the continuation (what to do after the binding). *)
let rec explicate_assign (e : L.exp) (v : var) (tl : tail) : tail =
  failwith "TODO"

(* Convert `if` expressions.
 * `e` is the condition part of the expression (evaluating to boolean).
 * The `then_tl` and `else_tl` are the two possible continuations. *)
and explicate_pred (e : L.exp) (then_tl : tail) (else_tl : tail) : tail =
  failwith "TODO"

(* Convert expressions in effect position.
 * Effect position includes:
 * - the expressions before the last expression in a `begin` expression
 * - the body expressions in a `while` loop
 * These are expressions that are only evaluated for their side effects.
 * Pure expressions in effect position are discarded,
 * since they can't have any effect. *)
and explicate_effect (e : L.exp) (tl : tail) : tail = failwith "TODO"

(* Convert expressions in tail position.
 * This includes:
 * 1) any top-level expression
 * 2) any expression at the end of a larger expression
 *    that will be evaluated to give the result of the entire expression
 * Examples of (2):
 * - the body of a `let`
 * - the then/else clauses of an `if`
 * - the last expression of a `begin` *)
and explicate_tail (e : L.exp) : tail = failwith "TODO"

(* Create a block from a tail.
 * Return a "goto" label to the block. *)
and create_block (tl : tail) : label =
  match tl with
  | Goto lbl -> lbl
  | Return _ | Seq _ | IfStmt _ ->
      let name = !fresh ~base:"block" ~sep:"_" in
      let lbl = Label name in
      basic_blocks := LabelMap.add lbl tl !basic_blocks;
      lbl

let init_globals () =
  fresh := make_gensym ();
  basic_blocks := LabelMap.empty

let explicate_control (L.Program e) =
  let _ = init_globals () in
  let t = explicate_tail e in
  (* The info field is empty here;
   * it will be filled in by the type checker. *)
  let info = Info { locals_types = [] } in
  let lts = [ (Label "start", t) ] @ LabelMap.bindings !basic_blocks in
  CProgram (info, lts)
