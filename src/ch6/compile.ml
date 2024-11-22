module S = Sexplib.Sexp

open Support
open Utils
open Ch6
open Alloc_utils
open Types

(* ----------------------------------------------------------------------
 * Command-line argument processing.
 * ---------------------------------------------------------------------- *)

let passes =
  ["ltup"; "tc1"; "sh"; "un"; "ea"; "ug"; "rc"; "ec"; "tc2" ; "ru";
   "si"; "ul"; "bi"; "ar"; "rj"; "pi"; "pc"; "pa"]

let passes_str = String.concat " " passes

(* Global variables. *)
let input_file = ref ""
let pass       = ref "pa"    (* pa is the last pass *)
let eval       = ref false
let only       = ref false   (* only do one pass *)
let regs       = ref ""

let usage_msg =
  "compile <filename>\n" ^
    "    [-pass <pass>] [-only] [-eval]\n" ^
    "    [-init-heap-size n] [-no-fix-label]\n" ^
    "    [-sexp-width n] [-sexp-indent n]\n" ^
    "    [-regs reg1,reg2,...]\n" ^
    "    [-help]"

let speclist =
  [
    ("-pass", Arg.Set_string pass,
     "Last compiler pass (one of: " ^ passes_str ^ ")");
    ("-only", Arg.Set only,
     "Only do one compiler pass");
    ("-eval", Arg.Set eval, "Evaluate after compiling");
    ("-init-heap-size", Arg.Set_int init_heap_size, "initial heap size");
    ("-no-fix-label", Arg.Set no_fix_label, "disable `fix_label`");
    ("-sexp-width",
     Arg.Set_int pp_line_limit, "S-expression maximum line width");
    ("-sexp-indent", Arg.Set_int pp_indent, "S-expression indent");
    ("-regs", Arg.Set_string regs, "Registers to use");
  ]

let usage () =
  begin
    Printf.eprintf "usage: ";
    Arg.usage speclist usage_msg;
    exit 1
  end

let anon_fun filename =
  input_file := filename

let err_msg msg =
  Printf.eprintf "error: %s\n%!" msg

let parse_args () =
  if Array.length Sys.argv = 1 then
    (* Only the program name; print a usage message. *)
    usage ()
  else
    begin
      Arg.current := 0;
      try
        Arg.parse_argv Sys.argv speclist anon_fun usage_msg
      with Arg.Help _ ->
        usage ()
    end

let check_pass pass = List.mem pass passes

let check_args () =
  if not (check_pass !pass) then
    begin
      err_msg ("invalid last pass: " ^ !pass);
      usage ();
    end
  else if !input_file = "" then
    begin
      err_msg ("no input filename provided");
      usage ();
    end

(* ----------------------------------------------------------------------
 * Running the compiler.
 * ---------------------------------------------------------------------- *)

(* Passes. *)
let tc1 = Type_check_ltup.type_check
let sh  = Shrink.shrink
let un  = Uniquify.uniquify
let ea  = Expose_allocation.expose_allocation
let ug  = Uncover_get.uncover_get
let rc  = Remove_complex.remove_complex_operands
let ec  = Explicate_control.explicate_control
let tc2 = Type_check_ctup.type_check
let ru  = Remove_unused.remove_unused_blocks
let si  = Select_instructions.select_instructions
let ul  = Uncover_live.uncover_live
let bi  = Build_interference.build_interference
let ar  = Allocate_registers.allocate_registers
let rj  = Remove_jumps.remove_jumps
let pi  = Patch_instructions.patch_instructions
let pc  = Prelude_conclusion.prelude_conclusion
let pa  = Print_asm.print_asm

(* File input. *)
let read_sexp = S.load_sexp
let read_ltup = Parser.parse

(* Conversions from S-expressions. *)
let ltup_in            = Ltup.program_of_sexp
let ltup_shrink_in     = Ltup_shrink.program_of_sexp
let lalloc_in          = Lalloc.program_of_sexp
let lalloc_get_in      = Lalloc_get.program_of_sexp
let lalloc_mon_in      = Lalloc_mon.program_of_sexp
let ctup_in            = Ctup.program_of_sexp
let x86_var_global1_in = X86_var_global.program_of_sexp
  X86_var_global.info1_of_sexp X86_var_global.binfo1_of_sexp
let x86_var_global2_in = X86_var_global.program_of_sexp
  X86_var_global.info1_of_sexp X86_var_global.binfo2_of_sexp
let x86_var_global3_in = X86_var_global.program_of_sexp
  X86_var_global.info2_of_sexp X86_var_global.binfo1_of_sexp
let x86_var_global4_in = X86_var_global.program_of_sexp
  X86_var_global.info3_of_sexp X86_var_global.binfo1_of_sexp
let x86_global_in      = X86_global.program_of_sexp
let x86_asm_in         = X86_asm.program_of_sexp

(* Evaluators. *)
let ltup_eval        = Interp_ltup.interp
let ltup_shrink_eval = Interp_ltup_shrink.interp
let lalloc_eval      = Interp_lalloc.interp
let lalloc_get_eval  = Interp_lalloc_get.interp
let lalloc_mon_eval  = Interp_lalloc_mon.interp
let ctup_eval        = Interp_ctup.interp

(* Conversions to S-expressions. *)
let ltup_out            = Ltup.sexp_of_program
let ltup_shrink_out     = Ltup_shrink.sexp_of_program
let lalloc_out          = Lalloc.sexp_of_program
let lalloc_get_out      = Lalloc_get.sexp_of_program
let lalloc_mon_out      = Lalloc_mon.sexp_of_program
let ctup_out            = Ctup.sexp_of_program
let x86_var_global1_out = X86_var_global.sexp_of_program
  X86_var_global.sexp_of_info1 X86_var_global.sexp_of_binfo1
let x86_var_global2_out = X86_var_global.sexp_of_program
  X86_var_global.sexp_of_info1 X86_var_global.sexp_of_binfo2
let x86_var_global3_out = X86_var_global.sexp_of_program
  X86_var_global.sexp_of_info2 X86_var_global.sexp_of_binfo1
let x86_var_global4_out = X86_var_global.sexp_of_program
  X86_var_global.sexp_of_info3 X86_var_global.sexp_of_binfo1
let x86_global_out      = X86_global.sexp_of_program
let x86_asm_out         = X86_asm.sexp_of_program

(* Print an integer. *)
let print_int i = Printf.printf "%d\n%!" i

let check_eval_only_error () =
  if !only then
    begin
      Printf.printf
        "ERROR: -eval and -only options are mutually exclusive!\n";
      exit 1
    end

(* Evaluator passes. *)
let eval_alist = [
  ("ltup", fun exp -> exp |> ltup_eval);
  ("tc1",  fun exp -> exp |> tc1 |> ltup_eval);
  ("sh",   fun exp -> exp |> tc1 |> sh |> ltup_shrink_eval);
  ("un",   fun exp -> exp |> tc1 |> sh |> un |> ltup_shrink_eval);
  ("ea",   fun exp -> exp |> tc1 |> sh |> un |> ea |> lalloc_eval);
  ("ug",   fun exp -> exp |> tc1 |> sh |> un |> ea |> ug |> lalloc_get_eval);
  ("rc",   fun exp ->
      exp |> tc1 |> sh |> un |> ea |> ug |> rc |> lalloc_mon_eval);
  ("ec",   fun exp ->
      exp |> tc1 |> sh |> un |> ea |> ug |> rc |> ec |> ctup_eval);
  ("tc2",  fun exp ->
      exp |> tc1 |> sh |> un |> ea |> ug |> rc |> ec |> tc2 |> ctup_eval);
  ("ru",   fun exp ->
      exp |> tc1 |> sh |> un |> ea |> ug |> rc |> ec |> tc2 |> ru |> ctup_eval);
]

(* Run the evaluator for a pass and print the result. *)
let run_evaluator pass filename =
  begin
    check_eval_only_error ();
    match List.assoc_opt pass eval_alist with
      | None ->
        if List.mem pass passes then
          begin
            Printf.eprintf "no evaluator for this pass\n";
            exit 1;
          end
        else
          begin
            Printf.eprintf "invalid pass: %s\n" pass;
            exit 1;
          end
      | Some f -> read_ltup filename |> f |> print_int
  end

(* The `-only` passes. *)
let only_alist = [
  ("ltup", fun sexp -> sexp |> ltup_in |> ltup_out);
  ("tc1",  fun sexp -> sexp |> ltup_in |> tc1 |> ltup_out);
  ("sh",   fun sexp -> sexp |> ltup_in |> sh |> ltup_shrink_out);
  ("un",   fun sexp -> sexp |> ltup_shrink_in |> un |> ltup_shrink_out);
  ("ea",   fun sexp -> sexp |> ltup_shrink_in |> ea |> lalloc_out);
  ("ug",   fun sexp -> sexp |> lalloc_in |> ug |> lalloc_get_out);
  ("rc",   fun sexp -> sexp |> lalloc_get_in |> rc |> lalloc_mon_out);
  ("ec",   fun sexp -> sexp |> lalloc_mon_in |> ec |> ctup_out);
  ("tc2",  fun sexp -> sexp |> ctup_in |> tc2 |> ctup_out);
  ("ru",   fun sexp -> sexp |> ctup_in |> ru |> ctup_out);
  ("si",   fun sexp -> sexp |> ctup_in |> si |> x86_var_global1_out);
  ("ul",   fun sexp -> sexp |> x86_var_global1_in |> ul |> x86_var_global2_out);
  ("bi",   fun sexp -> sexp |> x86_var_global2_in |> bi |> x86_var_global3_out);
  ("ar",   fun sexp -> sexp |> x86_var_global3_in |> ar |> x86_var_global4_out);
  ("rj",   fun sexp -> sexp |> x86_var_global4_in |> rj |> x86_var_global4_out);
  ("pi",   fun sexp -> sexp |> x86_var_global4_in |> pi |> x86_global_out);
  ("pc",   fun sexp -> sexp |> x86_global_in |> pc |> x86_asm_out);
]

(* Run a pass in `-only` mode and print the result. *)
let run_only pass filename =
  begin
    match List.assoc_opt pass only_alist with
      | None ->
        if pass = "pa" then
          read_sexp filename |> x86_asm_in |> pa |> print_string
        else
          begin
            Printf.eprintf "invalid pass: %s\n" pass;
            exit 1;
          end
      | Some f -> read_sexp filename |> f |> print_sexp
  end

(* The `-pass` passes, without `-only`. *)
let pass_alist = [
  ("ltup", fun exp -> exp |> ltup_out);
  ("tc1",  fun exp -> exp |> tc1 |> ltup_out);
  ("sh",   fun exp -> exp |> tc1 |> sh |> ltup_shrink_out);
  ("un",   fun exp -> exp |> tc1 |> sh |> un |> ltup_shrink_out);
  ("ea",   fun exp -> exp |> tc1 |> sh |> un |> ea |> lalloc_out);
  ("ug",   fun exp -> exp |> tc1 |> sh |> un |> ea |> ug |> lalloc_get_out);
  ("rc",   fun exp ->
      exp |> tc1 |> sh |> un |> ea |> ug |> rc |> lalloc_mon_out);
  ("ec",   fun exp ->
      exp |> tc1 |> sh |> un |> ea |> ug |> rc |> ec |> ctup_out);
  ("tc2",  fun exp ->
      exp |> tc1 |> sh |> un |> ea |> ug |> rc |> ec |> tc2 |> ctup_out);
  ("ru",   fun exp ->
      exp |> tc1 |> sh |> un |> ea |> ug |> rc |> ec |> tc2 |> ru |> ctup_out);
  ("si",   fun exp ->
      exp |> tc1 |> sh |> un |> ea |> ug |> rc |> ec |> tc2 |> ru |> si
          |> x86_var_global1_out);
  ("ul",   fun exp ->
      exp |> tc1 |> sh |> un |> ea |> ug |> rc |> ec |> tc2 |> ru |> si |> ul
          |> x86_var_global2_out);
  ("bi",   fun exp ->
      exp |> tc1 |> sh |> un |> ea |> ug |> rc |> ec |> tc2
          |> ru |> si |> ul |> bi
          |> x86_var_global3_out);
  ("ar",   fun exp ->
      exp |> tc1 |> sh |> un |> ea |> ug |> rc |> ec |> tc2
          |> ru |> si |> ul |> bi |> ar
          |> x86_var_global4_out);
  ("rj",   fun exp ->
      exp |> tc1 |> sh |> un |> ea |> ug |> rc |> ec |> tc2
          |> ru |> si |> ul |> bi |> ar |> rj
          |> x86_var_global4_out);
  ("pi",   fun exp ->
      exp |> tc1 |> sh |> un |> ea |> ug |> rc |> ec |> tc2
          |> ru |> si |> ul |> bi |> ar |> rj |> pi
          |> x86_global_out);
  ("pc",   fun exp ->
      exp |> tc1 |> sh |> un |> ea |> ug |> rc |> ec |> tc2
          |> ru |> si |> ul |> bi |> ar |> rj |> pi |> pc
          |> x86_asm_out);
]

(* Run a pass in normal mode and print the result. *)
let run_pass pass filename =
  begin
    match List.assoc_opt pass pass_alist with
      | None ->
        if pass = "pa" then
          read_ltup filename
            |> tc1 |> sh |> un |> ea |> ug |> rc |> ec |> tc2 |> ru
            |> si |> ul |> bi |> ar |> rj |> pi |> pc |> pa
            |> print_string
        else
          begin
            Printf.eprintf "invalid pass: %s\n" pass;
            exit 1;
          end
      | Some f -> read_ltup filename |> f |> print_sexp
  end

let run_compiler () =
  let filename = !input_file in
    if !eval then
      run_evaluator !pass filename
    else if !only then
      run_only !pass filename
    else
      run_pass !pass filename

(* ----------------------------------------------------------------------
 * Entry point.
 * ---------------------------------------------------------------------- *)

let () =
  try
    parse_args ();
    check_args ();
    if !regs <> "" then
      Allocate_registers.set_register_color_list (reg_list_of_string !regs);
    run_compiler ()
  with
    | Failure msg
    | Sys_error msg
    | Arg.Bad msg -> Printf.eprintf "%s\n%!" msg

