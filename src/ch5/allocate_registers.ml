open Support
open Types
open Utils
open X86_var_loop

module PQ = Priority_queue.Simple (OrderedLoc)

module Color =
  Graph_coloring.Make (OrderedLoc) (LocMap) (PQ) (LocUgraph)

(* Registers that are relevant to register allocation.
 * NOTE: We leave out reserved registers: 
 *   rax (return value)
 *   rsp (stack pointer)
 *   rbp (base pointer)
 *   r11 (used in later compilers)
 *   r15 (used in later compilers)
 *)
let registers_used =
  [Rcx; Rdx; Rsi; Rdi; R8; R9; R10;  (* caller-saved *)
   Rbx; R12; R13; R14]               (* callee-saved *)

(* We use references for these parameters so they can be
 * overridden by command-line arguments. *)
let last_register_color = ref 0
let register_color_list : (location * int) list ref = ref []

let register_list_ok regs =
  List.for_all (fun r -> List.mem r registers_used) regs

let set_register_color_list regs =
  if not (register_list_ok regs) then
    failwith "set_register_color_list: invalid register list"
  else
    let nums        = range 0 (List.length regs) in
    let reg_colors  = List.combine regs nums in
    let assignments = [(Rflags, -6); (Rsp, -2); (Rax, -1)] @ reg_colors in
    let rc_list     =
      List.map (fun (r, i) -> (RegL r, i)) assignments
    in
      begin
        register_color_list := rc_list;
        last_register_color := List.length regs - 1
      end

(* Default color assignments to registers. *)
let _ = set_register_color_list registers_used

let register_color_map () : int LocMap.t =
  LocMap.of_list !register_color_list

let color_register_map () : location IntMap.t =
  List.fold_left
    (fun m (l, i) -> IntMap.add i l m)
    IntMap.empty
    !register_color_list

(* Get the location corresponding to a color (int).
 * Usually this will be a register, but if there aren't
 * enough registers, it will be a stack location. *)
let location_of_color (i : int) : location =
  match IntMap.find_opt i (color_register_map ()) with
    | None ->
      failwith "TODO"
    | Some l -> l

(* ----------------------------------------------------------------- *) 

(* Extract just the variable mappings from a graph coloring,
 * and map them to their (register and stack) locations. *)
let varmap_of_colormap (color_map : int LocMap.t) : location VarMap.t =
  failwith "TODO"

(* Determine the variable -> location mapping based on the
 * interference graph. *)
let get_variable_location_map (g : LocUgraph.t) : location VarMap.t =
  (* Perform the graph coloring, and convert to var -> loc map. *)
  varmap_of_colormap (Color.color g (register_color_map ()))


(* Convert all the instructions with arguments. *)
let convert_instr (map : location VarMap.t) (ins : instr) : instr =
  failwith "TODO"

(* Convert a block.  Block info is empty, so it's just passed through. *)
let convert_block (map : location VarMap.t) (bl : 'a block) : 'a block =
  let (Block (bi, ins)) = bl in
    Block (bi, List.map (convert_instr map) ins)

(* Get the count of the number of variables spilled to the stack. *)
let get_num_spilled (map : location VarMap.t) : int =
  failwith "TODO"

(* Compute the set of callee-save registers used. *)
let get_used_callee (map : location VarMap.t) : RegSet.t =
  failwith "TODO"

(* Validation function: checks that there are no remaining
 * variable references in the code. *)
let check_no_variables (prog : (info3, binfo1) program) : unit =
  let is_var = function
    | Var _ -> true
    | _ -> false
  in
  let has_var = function
    | Addq   (a1, a2)
    | Subq   (a1, a2)
    | Xorq   (a1, a2)
    | Cmpq   (a1, a2)
    | Movq   (a1, a2)
    | Movzbq (a1, a2) -> is_var a1 || is_var a2
    | Negq   a
    | Set    (_, a)
    | Pushq  a
    | Popq   a -> is_var a
    | _ -> false
  in
  let X86Program (_, lbs) = prog in
  let (_, bs) = List.split lbs in
  let get_instrs (Block (_, b)) = b in
  let (ins : instr list) = bs |> List.map get_instrs |> List.concat in
  if List.exists has_var ins then
    failwith 
      ("allocate_registers: check_no_variables: " ^
       "variables still present in code after pass")
  else ()

(* Allocate registers to variables in the code. *)
let allocate_registers (prog : (info2, binfo1) program)
      : (info3, binfo1) program =
  let (X86Program (Info2 info, lbs)) = prog in
  let (map : location VarMap.t) =
    get_variable_location_map info.conflicts
  in
  let info' = Info3 
    { 
      locals_types = info.locals_types;
      num_spilled  = get_num_spilled map;
      used_callee  = get_used_callee map
    }
  in
  (* Rewrite the code using the variable->register map. *)
  let lbs' =
    List.map 
      (fun (label, block) -> (label, convert_block map block))
      lbs 
  in
  let prog' = X86Program (info', lbs') in
  let () = check_no_variables prog' in
    prog'
