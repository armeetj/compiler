module S = Sexplib.Sexp
open Support
open Utils
open Ch7
open Alloc_utils
open Types

(* ----------------------------------------------------------------------
 * Command-line argument processing.
 * ---------------------------------------------------------------------- *)

let passes =
  [ "lfun"
  ; "tc1"
  ; "sh"
  ; "un"
  ; "rf"
  ; "lf"
  ; "tc1b"
  ; "ea"
  ; "ug"
  ; "rc"
  ; "ec"
  ; "tc2"
  ; "ru"
  ; "si"
  ; "ul"
  ; "bi"
  ; "ar"
  ; "rj"
  ; "pi"
  ; "pc"
  ; "opt"
  ; "pa" ]

let passes_str = String.concat " " passes

(* Global variables. *)
let input_file = ref ""

let pass = ref "pa" (* pa is the last pass *)

let eval = ref false

let only = ref false (* only do one pass *)

let regs = ref ""

let usage_msg =
  "compile <filename>\n" ^ "    [-pass <pass>] [-only] [-eval]\n"
  ^ "    [-init-heap-size n] [-no-fix-label]\n"
  ^ "    [-sexp-width n] [-sexp-indent n]\n" ^ "    [-regs reg1,reg2,...]\n"
  ^ "    [-help]"

let speclist =
  [ ( "-pass"
    , Arg.Set_string pass
    , "\tSet last compiler pass (one of: " ^ passes_str ^ ")." )
  ; ("-only", Arg.Set only, "\tOnly do one compiler pass")
  ; ("-eval", Arg.Set eval, "\tEvaluate after compiling")
  ; ("-init-heap-size", Arg.Set_int init_heap_size, "\tSet initial heap size")
  ; ("-no-fix-label", Arg.Set no_fix_label, "\tDisable `fix_label`")
  ; ( "-sexp-width"
    , Arg.Set_int pp_line_limit
    , "\tSet S-expression maximum line width" )
  ; ("-sexp-indent", Arg.Set_int pp_indent, "\tSet S-expression indent")
  ; ("-regs", Arg.Set_string regs, "\tSet registers to use") ]

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
    try Arg.parse_argv Sys.argv speclist anon_fun usage_msg with
    | Arg.Help _ -> usage () )

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
let tc1 = Type_check_lfun.type_check

let sh = Shrink.shrink

let un = Uniquify.uniquify

let rf = Reveal_functions.reveal_functions

let lf = Limit_functions.limit_functions

let tc1b = Type_check_lfun_ref.type_check

let ea = Expose_allocation.expose_allocation

let ug = Uncover_get.uncover_get

let rc = Remove_complex.remove_complex_operands

let ec = Explicate_control.explicate_control

let tc2 = Type_check_cfun.type_check

let ru = Remove_unused.remove_unused_blocks

let si = Select_instructions.select_instructions

let ul = Uncover_live.uncover_live

let bi = Build_interference.build_interference

let ar = Allocate_registers.allocate_registers

let rj = Remove_jumps.remove_jumps

let pi = Patch_instructions.patch_instructions

let pc = Prelude_conclusion.prelude_conclusion

let opt = Optimize.optimize

let pa = Print_asm.print_asm

(* File input. *)
let read_sexp = S.load_sexp

let read_lfun = Parser.parse

(* Conversions from S-expressions. *)
let lfun_in = Lfun.program_of_sexp

let lfun_shrink_in = Lfun_shrink.program_of_sexp

let lfun_ref_in = Lfun_ref.program_of_sexp

let lfun_ref_alloc_in = Lfun_ref_alloc.program_of_sexp

let lfun_ref_alloc_get_in = Lfun_ref_alloc_get.program_of_sexp

let lfun_ref_mon_in = Lfun_ref_mon.program_of_sexp

let cfun_in = Cfun.program_of_sexp

let x86_var_def1_in =
  X86_var_def.program_of_sexp X86_var_def.finfo1_of_sexp
    X86_var_def.binfo1_of_sexp

let x86_var_def2_in =
  X86_var_def.program_of_sexp X86_var_def.finfo1_of_sexp
    X86_var_def.binfo2_of_sexp

let x86_var_def3_in =
  X86_var_def.program_of_sexp X86_var_def.finfo2_of_sexp
    X86_var_def.binfo1_of_sexp

let x86_var_def4_in =
  X86_var_def.program_of_sexp X86_var_def.finfo3_of_sexp
    X86_var_def.binfo1_of_sexp

let x86_def_in = X86_def.program_of_sexp

let x86_asm_in = X86_asm.program_of_sexp

(* Evaluators. *)
let lfun_eval = Interp_lfun.interp

let lfun_shrink_eval = Interp_lfun_shrink.interp

let lfun_ref_eval = Interp_lfun_ref.interp

let lfun_ref_alloc_eval = Interp_lfun_ref_alloc.interp

let lfun_ref_alloc_get_eval = Interp_lfun_ref_alloc_get.interp

let lfun_ref_mon_eval = Interp_lfun_ref_mon.interp

let cfun_eval = Interp_cfun.interp

(* Conversions to S-expressions. *)
let lfun_out = Lfun.sexp_of_program

let lfun_shrink_out = Lfun_shrink.sexp_of_program

let lfun_ref_out = Lfun_ref.sexp_of_program

let lfun_ref_alloc_out = Lfun_ref_alloc.sexp_of_program

let lfun_ref_alloc_get_out = Lfun_ref_alloc_get.sexp_of_program

let lfun_ref_mon_out = Lfun_ref_mon.sexp_of_program

let cfun_out = Cfun.sexp_of_program

let x86_var_def1_out =
  X86_var_def.sexp_of_program X86_var_def.sexp_of_finfo1
    X86_var_def.sexp_of_binfo1

let x86_var_def2_out =
  X86_var_def.sexp_of_program X86_var_def.sexp_of_finfo1
    X86_var_def.sexp_of_binfo2

let x86_var_def3_out =
  X86_var_def.sexp_of_program X86_var_def.sexp_of_finfo2
    X86_var_def.sexp_of_binfo1

let x86_var_def4_out =
  X86_var_def.sexp_of_program X86_var_def.sexp_of_finfo3
    X86_var_def.sexp_of_binfo1

let x86_def_out = X86_def.sexp_of_program

let x86_asm_out = X86_asm.sexp_of_program

(* Print an integer. *)
let print_int i = Printf.printf "%d\n%!" i

let check_eval_only_error () =
  if !only then (
    Printf.printf "ERROR: -eval and -only options are mutually exclusive!\n" ;
    exit 1 )

(* Evaluator passes. *)
let eval_alist =
  [ ("lfun", fun exp -> exp |> lfun_eval)
  ; ("tc1", fun exp -> exp |> tc1 |> lfun_eval)
  ; ("sh", fun exp -> exp |> tc1 |> sh |> lfun_shrink_eval)
  ; ("un", fun exp -> exp |> tc1 |> sh |> un |> lfun_shrink_eval)
  ; ("rf", fun exp -> exp |> tc1 |> sh |> un |> rf |> lfun_ref_eval)
  ; ("lf", fun exp -> exp |> tc1 |> sh |> un |> rf |> lf |> lfun_ref_eval)
  ; ( "tc1b"
    , fun exp -> exp |> tc1 |> sh |> un |> rf |> lf |> tc1b |> lfun_ref_eval )
  ; ( "ea"
    , fun exp ->
        exp |> tc1 |> sh |> un |> rf |> lf |> tc1b |> ea |> lfun_ref_alloc_eval
    )
  ; ( "ug"
    , fun exp ->
        exp |> tc1 |> sh |> un |> rf |> lf |> tc1b |> ea |> ug
        |> lfun_ref_alloc_get_eval )
  ; ( "rc"
    , fun exp ->
        exp |> tc1 |> sh |> un |> rf |> lf |> tc1b |> ea |> ug |> rc
        |> lfun_ref_mon_eval )
  ; ( "ec"
    , fun exp ->
        exp |> tc1 |> sh |> un |> rf |> lf |> tc1b |> ea |> ug |> rc |> ec
        |> cfun_eval )
  ; ( "tc2"
    , fun exp ->
        exp |> tc1 |> sh |> un |> rf |> lf |> tc1b |> ea |> ug |> rc |> ec
        |> tc2 |> cfun_eval )
  ; ( "ru"
    , fun exp ->
        exp |> tc1 |> sh |> un |> rf |> lf |> tc1b |> ea |> ug |> rc |> ec
        |> tc2 |> ru |> cfun_eval ) ]

(* Run the evaluator for a pass and print the result. *)
let run_evaluator pass filename =
  check_eval_only_error () ;
  match List.assoc_opt pass eval_alist with
  | None ->
    if List.mem pass passes then (
      Printf.eprintf "no evaluator for this pass\n" ;
      exit 1 )
    else (
      Printf.eprintf "invalid pass: %s\n" pass ;
      exit 1 )
  | Some f -> read_lfun filename |> f |> print_int

(* The `-only` passes. *)
let only_alist =
  [ ("lfun", fun sexp -> sexp |> lfun_in |> lfun_out)
  ; ("tc1", fun sexp -> sexp |> lfun_in |> tc1 |> lfun_out)
  ; ("sh", fun sexp -> sexp |> lfun_in |> sh |> lfun_shrink_out)
  ; ("un", fun sexp -> sexp |> lfun_shrink_in |> un |> lfun_shrink_out)
  ; ("rf", fun sexp -> sexp |> lfun_shrink_in |> rf |> lfun_ref_out)
  ; ("lf", fun sexp -> sexp |> lfun_ref_in |> lf |> lfun_ref_out)
  ; ("tc1b", fun sexp -> sexp |> lfun_ref_in |> tc1b |> lfun_ref_out)
  ; ("ea", fun sexp -> sexp |> lfun_ref_in |> ea |> lfun_ref_alloc_out)
  ; ("ug", fun sexp -> sexp |> lfun_ref_alloc_in |> ug |> lfun_ref_alloc_get_out)
  ; ("rc", fun sexp -> sexp |> lfun_ref_alloc_get_in |> rc |> lfun_ref_mon_out)
  ; ("ec", fun sexp -> sexp |> lfun_ref_mon_in |> ec |> cfun_out)
  ; ("tc2", fun sexp -> sexp |> cfun_in |> tc2 |> cfun_out)
  ; ("ru", fun sexp -> sexp |> cfun_in |> ru |> cfun_out)
  ; ("si", fun sexp -> sexp |> cfun_in |> si |> x86_var_def1_out)
  ; ("ul", fun sexp -> sexp |> x86_var_def1_in |> ul |> x86_var_def2_out)
  ; ("bi", fun sexp -> sexp |> x86_var_def2_in |> bi |> x86_var_def3_out)
  ; ("ar", fun sexp -> sexp |> x86_var_def3_in |> ar |> x86_var_def4_out)
  ; ("rj", fun sexp -> sexp |> x86_var_def4_in |> rj |> x86_var_def4_out)
  ; ("pi", fun sexp -> sexp |> x86_var_def4_in |> pi |> x86_def_out)
  ; ("pc", fun sexp -> sexp |> x86_def_in |> pc |> x86_asm_out)
  ; ("opt", fun sexp -> sexp |> x86_asm_in |> opt |> x86_asm_out) ]

(* Run a pass in `-only` mode and print the result. *)
let run_only pass filename =
  match List.assoc_opt pass only_alist with
  | None ->
    if pass = "pa" then read_sexp filename |> x86_asm_in |> pa |> print_string
    else (
      Printf.eprintf "invalid pass: %s\n" pass ;
      exit 1 )
  | Some f -> read_sexp filename |> f |> print_sexp

(* The `-pass` passes, without `-only`. *)
let pass_alist =
  [ ("lfun", fun exp -> exp |> lfun_out)
  ; ("tc1", fun exp -> exp |> tc1 |> lfun_out)
  ; ("sh", fun exp -> exp |> tc1 |> sh |> lfun_shrink_out)
  ; ("un", fun exp -> exp |> tc1 |> sh |> un |> lfun_shrink_out)
  ; ("rf", fun exp -> exp |> tc1 |> sh |> un |> rf |> lfun_ref_out)
  ; ("lf", fun exp -> exp |> tc1 |> sh |> un |> rf |> lf |> lfun_ref_out)
  ; ( "tc1b"
    , fun exp -> exp |> tc1 |> sh |> un |> rf |> lf |> tc1b |> lfun_ref_out )
  ; ( "ea"
    , fun exp ->
        exp |> tc1 |> sh |> un |> rf |> lf |> tc1b |> ea |> lfun_ref_alloc_out
    )
  ; ( "ug"
    , fun exp ->
        exp |> tc1 |> sh |> un |> rf |> lf |> tc1b |> ea |> ug
        |> lfun_ref_alloc_get_out )
  ; ( "rc"
    , fun exp ->
        exp |> tc1 |> sh |> un |> rf |> lf |> tc1b |> ea |> ug |> rc
        |> lfun_ref_mon_out )
  ; ( "ec"
    , fun exp ->
        exp |> tc1 |> sh |> un |> rf |> lf |> tc1b |> ea |> ug |> rc |> ec
        |> cfun_out )
  ; ( "tc2"
    , fun exp ->
        exp |> tc1 |> sh |> un |> rf |> lf |> tc1b |> ea |> ug |> rc |> ec
        |> tc2 |> cfun_out )
  ; ( "ru"
    , fun exp ->
        exp |> tc1 |> sh |> un |> rf |> lf |> tc1b |> ea |> ug |> rc |> ec
        |> tc2 |> ru |> cfun_out )
  ; ( "si"
    , fun exp ->
        exp |> tc1 |> sh |> un |> rf |> lf |> tc1b |> ea |> ug |> rc |> ec
        |> tc2 |> ru |> si |> x86_var_def1_out )
  ; ( "ul"
    , fun exp ->
        exp |> tc1 |> sh |> un |> rf |> lf |> tc1b |> ea |> ug |> rc |> ec
        |> tc2 |> ru |> si |> ul |> x86_var_def2_out )
  ; ( "bi"
    , fun exp ->
        exp |> tc1 |> sh |> un |> rf |> lf |> tc1b |> ea |> ug |> rc |> ec
        |> tc2 |> ru |> si |> ul |> bi |> x86_var_def3_out )
  ; ( "ar"
    , fun exp ->
        exp |> tc1 |> sh |> un |> rf |> lf |> tc1b |> ea |> ug |> rc |> ec
        |> tc2 |> ru |> si |> ul |> bi |> ar |> x86_var_def4_out )
  ; ( "rj"
    , fun exp ->
        exp |> tc1 |> sh |> un |> rf |> lf |> tc1b |> ea |> ug |> rc |> ec
        |> tc2 |> ru |> si |> ul |> bi |> ar |> rj |> x86_var_def4_out )
  ; ( "pi"
    , fun exp ->
        exp |> tc1 |> sh |> un |> rf |> lf |> tc1b |> ea |> ug |> rc |> ec
        |> tc2 |> ru |> si |> ul |> bi |> ar |> rj |> pi |> x86_def_out )
  ; ( "pc"
    , fun exp ->
        exp |> tc1 |> sh |> un |> rf |> lf |> tc1b |> ea |> ug |> rc |> ec
        |> tc2 |> ru |> si |> ul |> bi |> ar |> rj |> pi |> pc |> x86_asm_out )
  ; ( "opt"
    , fun exp ->
        exp |> tc1 |> sh |> un |> rf |> lf |> tc1b |> ea |> ug |> rc |> ec
        |> tc2 |> ru |> si |> ul |> bi |> ar |> rj |> pi |> pc |> opt
        |> x86_asm_out ) ]

(* Run a pass in normal mode and print the result. *)
let run_pass pass filename =
  match List.assoc_opt pass pass_alist with
  | None ->
    if pass = "pa" then
      read_lfun filename |> tc1 |> sh |> un |> rf |> lf |> tc1b |> ea |> ug
      |> rc |> ec |> tc2 |> ru |> si |> ul |> bi |> ar |> rj |> pi |> pc |> opt
      |> pa |> print_string
    else (
      Printf.eprintf "invalid pass: %s\n" pass ;
      exit 1 )
  | Some f -> read_lfun filename |> f |> print_sexp

let run_compiler () =
  let filename = !input_file in
  if !eval then run_evaluator !pass filename
  else if !only then run_only !pass filename
  else run_pass !pass filename

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
  with
  | Failure msg
   |Sys_error msg
   |Type_check.Type_error msg
   |Arg.Bad msg ->
    Printf.eprintf "%s\n%!" msg
