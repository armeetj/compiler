open Support
open Types
open Utils
module C = Cfun
open X86_var_def

(* NOTE: `fix_label` is needed for global variables as well as functions.
   MacOS, for instance, puts `_` before the names of both in assembly code. *)


let rec tail_instructions (f_lbl : label) (i : C.tail) : instr list =
  failwith "TODO"

let convert_lt (f_lbl : label) (lt : (label * C.tail))
      : label * binfo1 block =
  let (lbl, tail) = lt in
  let block = Block (Binfo1, tail_instructions f_lbl tail) in
    (lbl, block)

(*** New for chapter 7 ***)
(* Add argument passing instructions to the front of `start` blocks only.
   All other blocks are unchanged.
   See section 7.8 (p. 139) in the book.
   Also change the `start` block label to `FNAME_start`,
   where FNAME is `f_lbl`.
   `nparams` is the length of the `args` list.
   *)
let add_arg_instrs
      (f_lbl : label)
      (nparams : int)
      (args : (var * ty) list)
      (body : (label * binfo1 block) list)
        : (label * binfo1 block) list =
  if nparams > 6 then
    failwith "compiler error: add_arg_instrs: too many arguments"
  else
  failwith "TODO"

let select_instructions_def (d : C.def) : (finfo1, binfo1) def =
  let (C.Def (f_lbl, fcont)) = d in
  let C.{ args; locals; body; _ } = fcont in
  let body'   = List.map (convert_lt f_lbl) body in
  let nparams = List.length args in
  let body''  = add_arg_instrs f_lbl nparams args body' in
  (* Make the argument variables into local variables. *)
  let locals' = args @ locals in
  let fcont'  = { nparams; locals = locals'; body = body'' } in
  (* We don't change `f_lbl` here because we will use it in
     `prelude_conclusion.ml` to generate
     the `FNAME_main` and `FNAME_conclusion` labels,
     as well as fixing the `FNAME_main` label. *)
    Def (f_lbl, Finfo1, fcont')

let select_instructions (prog : C.program) : (finfo1, binfo1) program =
  let (C.CProgram defs) = prog in
    X86Program (List.map select_instructions_def defs)
