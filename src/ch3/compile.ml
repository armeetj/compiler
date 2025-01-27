module S = Sexplib.Sexp
open Support
open Utils
open Ch3
open Types

(* ----------------------------------------------------------------------
 * Command-line argument processing.
 * ---------------------------------------------------------------------- *)

let passes = ["lvar"; "un"; "rc"; "ec"; "si"; "ul"; "bi"; "ar"; "pi"; "pc"; "pa"]

let passes_str = String.concat " " passes

(* Global variables. *)
let input_file = ref ""

let pass = ref "pa" (* pa is the last pass *)

let eval = ref false

let only = ref false (* only do one pass *)

let regs = ref ""

(* TODO: write a `spaces` function in `support/utils.ml[i]` and use it. *)
let usage_msg =
  "compile <filename> " ^ "[-pass <pass>] [-only] [-eval] [-no-fix-label]\n"
  ^ "                          [-sexp-width n] [-sexp-indent n]\n"
  ^ "                          [-regs reg1,reg2,...] [-help]"

let speclist =
  [ ( "-pass"
    , Arg.Set_string pass
    , "Last compiler pass (one of: " ^ passes_str ^ ")" )
  ; ("-only", Arg.Set only, "Only do one compiler pass")
  ; ("-eval", Arg.Set eval, "Evaluate after compiling")
  ; ("-no-fix-label", Arg.Set no_fix_label, "disable `fix_label`")
  ; ("-sexp-width", Arg.Set_int pp_line_limit, "S-expression maximum line width")
  ; ("-sexp-indent", Arg.Set_int pp_indent, "S-expression indent")
  ; ("-regs", Arg.Set_string regs, "Registers to use") ]

let usage () =
  Printf.eprintf "usage: " ;
  Arg.usage speclist usage_msg ;
  exit 1

let anon_fun filename = input_file := filename

let err_msg msg = Printf.eprintf "error: %s\n%!" msg

let parse_args () =
  if Array.length Sys.argv = 1 then
    (* Only the program name; print a usage message. *)
    usage ()
  else (
    Arg.current := 0 ;
    try Arg.parse_argv Sys.argv speclist anon_fun usage_msg
    with Arg.Help _ -> usage () )

let check_pass pass = List.mem pass passes

let check_args () =
  if not (check_pass !pass) then (
    err_msg ("invalid last pass: " ^ !pass) ;
    usage () )
  else if !input_file = "" then (
    err_msg "no input filename provided" ;
    usage () )

(* ----------------------------------------------------------------------
 * Running the compiler.
 * ---------------------------------------------------------------------- *)

(* Passes. *)
let un = Uniquify.uniquify

let rc = Remove_complex.remove_complex_operands

let ec = Explicate_control.explicate_control

let si = Select_instructions.select_instructions

let ul = Uncover_live.uncover_live

let bi = Build_interference.build_interference

let ar = Allocate_registers.allocate_registers

let pi = Patch_instructions.patch_instructions

let pc = Prelude_conclusion.prelude_conclusion

let pa = Print_asm.print_asm

(* File input. *)
let read_sexp = S.load_sexp

let read_lvar = Parser.parse

(* Conversions from S-expressions. *)
let lvar_in = Lvar.program_of_sexp

let lvar_mon_in = Lvar_mon.program_of_sexp

let cvar_in = Cvar.program_of_sexp

let x86_var1_in =
  X86_var.program_of_sexp X86_var.info1_of_sexp X86_var.binfo1_of_sexp

let x86_var2_in =
  X86_var.program_of_sexp X86_var.info1_of_sexp X86_var.binfo2_of_sexp

let x86_var3_in =
  X86_var.program_of_sexp X86_var.info2_of_sexp X86_var.binfo1_of_sexp

let x86_var4_in =
  X86_var.program_of_sexp X86_var.info3_of_sexp X86_var.binfo1_of_sexp

let x86_int_in = X86_int.program_of_sexp

let x86_asm_in = X86_asm.program_of_sexp

(* Evaluators. *)
let lvar_eval = Interp_lvar.interp

let lvar_mon_eval = Interp_lvar_mon.interp

let cvar_eval = Interp_cvar.interp

(* Conversions to S-expressions. *)
let lvar_out = Lvar.sexp_of_program

let lvar_mon_out = Lvar_mon.sexp_of_program

let cvar_out = Cvar.sexp_of_program

let x86_var1_out =
  X86_var.sexp_of_program X86_var.sexp_of_info1 X86_var.sexp_of_binfo1

let x86_var2_out =
  X86_var.sexp_of_program X86_var.sexp_of_info1 X86_var.sexp_of_binfo2

let x86_var3_out =
  X86_var.sexp_of_program X86_var.sexp_of_info2 X86_var.sexp_of_binfo1

let x86_var4_out =
  X86_var.sexp_of_program X86_var.sexp_of_info3 X86_var.sexp_of_binfo1

let x86_int_out = X86_int.sexp_of_program

let x86_asm_out = X86_asm.sexp_of_program

(* Print an integer. *)
let print_int i = Printf.printf "%d\n%!" i

let no_case args =
  Printf.eprintf "ERROR: no case for arguments: " ;
  List.iter (fun a -> Printf.eprintf "%s " a) args ;
  Printf.eprintf "\n\n%!" ;
  usage ()

let check_eval_only_error () =
  if !only then (
    Printf.printf "ERROR: -eval and -only options are mutually exclusive!\n" ;
    exit 1 )

let run_compiler () =
  let filename = !input_file in
  let args = List.tl (Array.to_list Sys.argv) in
  match !pass with
  | "lvar" ->
      if !eval then (
        check_eval_only_error () ;
        read_lvar filename |> lvar_eval |> print_int )
      else
        (* same with -only as without *)
        read_lvar filename |> lvar_out |> print_sexp
  | "un" ->
      if !eval then (
        check_eval_only_error () ;
        read_lvar filename |> un |> lvar_eval |> print_int )
      else if !only then
        read_sexp filename |> lvar_in |> un |> lvar_out |> print_sexp
      else read_lvar filename |> un |> lvar_out |> print_sexp
  | "rc" ->
      if !eval then (
        check_eval_only_error () ;
        read_lvar filename |> un |> rc |> lvar_mon_eval |> print_int )
      else if !only then
        read_sexp filename |> lvar_in |> rc |> lvar_mon_out |> print_sexp
      else read_lvar filename |> un |> rc |> lvar_mon_out |> print_sexp
  | "ec" ->
      if !eval then (
        check_eval_only_error () ;
        read_lvar filename |> un |> rc |> ec |> cvar_eval |> print_int )
      else if !only then
        read_sexp filename |> lvar_mon_in |> ec |> cvar_out |> print_sexp
      else read_lvar filename |> un |> rc |> ec |> cvar_out |> print_sexp
  | "si" ->
      if !eval then Printf.printf "no evaluator for this pass\n"
      else if !only then
        read_sexp filename |> cvar_in |> si |> x86_var1_out |> print_sexp
      else
        read_lvar filename |> un |> rc |> ec |> si |> x86_var1_out |> print_sexp
  | "ul" ->
      if !eval then Printf.printf "no evaluator for this pass\n"
      else if !only then
        read_sexp filename |> x86_var1_in |> ul |> x86_var2_out |> print_sexp
      else
        read_lvar filename |> un |> rc |> ec |> si |> ul |> x86_var2_out
        |> print_sexp
  | "bi" ->
      if !eval then Printf.printf "no evaluator for this pass\n"
      else if !only then
        read_sexp filename |> x86_var2_in |> bi |> x86_var3_out |> print_sexp
      else
        read_lvar filename |> un |> rc |> ec |> si |> ul |> bi |> x86_var3_out
        |> print_sexp
  | "ar" ->
      if !eval then Printf.printf "no evaluator for this pass\n"
      else if !only then
        read_sexp filename |> x86_var3_in |> ar |> x86_var4_out |> print_sexp
      else
        read_lvar filename |> un |> rc |> ec |> si |> ul |> bi |> ar
        |> x86_var4_out |> print_sexp
  | "pi" ->
      if !eval then Printf.printf "no evaluator for this pass\n"
      else if !only then
        read_sexp filename |> x86_var4_in |> pi |> x86_int_out |> print_sexp
      else
        read_lvar filename |> un |> rc |> ec |> si |> ul |> bi |> ar |> pi
        |> x86_int_out |> print_sexp
  | "pc" ->
      if !eval then Printf.printf "no evaluator for this pass\n"
      else if !only then
        read_sexp filename |> x86_int_in |> pc |> x86_asm_out |> print_sexp
      else
        read_lvar filename |> un |> rc |> ec |> si |> ul |> bi |> ar |> pi |> pc
        |> x86_asm_out |> print_sexp
  | "pa" ->
      if !eval then Printf.printf "no evaluator for this pass\n"
      else if !only then read_sexp filename |> x86_asm_in |> pa |> print_string
      else
        read_lvar filename |> un |> rc |> ec |> si |> ul |> bi |> ar |> pi |> pc
        |> pa |> print_string
  | _ ->
      no_case args

(* ----------------------------------------------------------------------
 * Entry point.
 * ---------------------------------------------------------------------- *)

let () =
  try
    parse_args () ;
    check_args () ;
    if !regs <> "" then
      Allocate_registers.set_register_color_list (reg_list_of_string !regs) ;
    run_compiler ()
  with Failure msg | Sys_error msg | Arg.Bad msg ->
    Printf.eprintf "%s\n%!" msg
