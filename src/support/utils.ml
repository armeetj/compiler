open Sexplib.Sexp

(* ---------------------------------------------------------------------- 
 * Option utilities.
 * ---------------------------------------------------------------------- *)

(* This function allows you to treat the Some constructors like a function,
 * so you can do e.g. `some @@ Printf.sprintf "%x" i` *)
let some x = Some x

(* ---------------------------------------------------------------------- 
 * Sexp utilities.
 * ---------------------------------------------------------------------- *)

(* These functions allow you to treat constructors like functions,
 * so you can do e.g. `slist @@ [satom "foo", satom "bar"]`. *)

let satom s = Atom s

let slist s = List s

(* ---------------------------------------------------------------------- 
 * Math utilities.
 * ---------------------------------------------------------------------- *)

let align_16 i =
  assert (i >= 0) ;
  let m = i mod 16 in
  if m = 0 then i else i + (16 - m)

(* ---------------------------------------------------------------------- 
 * String utilities.
 * ---------------------------------------------------------------------- *)

let change_filename_ext ~filename ~ext1 ~ext2 =
  if String.ends_with ~suffix:ext1 filename then
    let len = String.length filename - String.length ext1 in
    let root = String.sub filename 0 len in
    root ^ ext2
  else filename

let split_on_spaces s =
  List.filter (fun s -> s <> "") (String.split_on_char ' ' s)

let string_map ?(sep = "") f lst = String.concat sep (List.map f lst)

module StringSet = Set.Make (struct
  type t = string

  let compare = Stdlib.compare
end)

let no_string_repeats ss =
  let sset = StringSet.of_list ss in
  StringSet.cardinal sset = List.length ss

(* ---------------------------------------------------------------------- 
 * List utilities.
 * ---------------------------------------------------------------------- *)

let rec last = function
  | [] -> invalid_arg "last: empty list"
  | [x] -> x
  | _ :: t -> last t

let butlast lst =
  let rec iter collect rest =
    match rest with
    | [] -> invalid_arg "butlast: empty list"
    | [_] -> List.rev collect
    | h :: t -> iter (h :: collect) t
  in
  iter [] lst

let rec take n lst =
  match (n, lst) with
  | _ when n < 0 -> invalid_arg "take: negative n"
  | 0, _ -> []
  | _, [] -> invalid_arg "take: empty list"
  | _, h :: t -> h :: take (n - 1) t

let rec drop n lst =
  match (n, lst) with
  | _ when n < 0 -> invalid_arg "drop: negative n"
  | 0, _ -> lst
  | _, [] -> invalid_arg "drop: empty list"
  | _, _ :: t -> drop (n - 1) t

let range m n =
  let rec iter m lst =
    if m = n then List.rev lst else iter (m + 1) (m :: lst)
  in
  iter m []

(* ---------------------------------------------------------------------- 
 * S-expression pretty-printer.
 * ---------------------------------------------------------------------- *)

(*

The overall approach is the following:

* Atoms are formatted as the corresponding string.
* For lists:
  - Try to format the list on a single line.
    If the line is less than some limit, accept it.
    Otherwise, reject it and format it on multiple lines.
  - If the list starts with another list,
    indent all list elements the same amount.
  - If the list starts with an atom,
    indent the rest of the list elements an extra `pp_indent` spaces.
*)

(* Beyond this length limit, lists have to be formatted on multiple lines. *)
let pp_line_limit = ref 40

(* Pretty-printer indent. *)
let pp_indent = ref 2

let rec flat_format s =
  match s with
  | Atom s -> s
  | List l -> "(" ^ String.concat " " (List.map flat_format l) ^ ")"

(* Add indent to each item of a list. *)
let add_indent n lst = List.map (fun (i, s) -> (i + n, s)) lst

(* Add an open parenthesis to the front of the first line.
   Add 1 to the indents of all other lines. *)
let add_open (lst : (int * string) list) : (int * string) list =
  match lst with
  | [] -> failwith "no items in list"
  | (n, s) :: t -> (n, "(" ^ s) :: add_indent 1 t

(* Add a close parenthesis to the end of the last line. *)
let rec add_close (lst : (int * string) list) : (int * string) list =
  match lst with
  | [] -> failwith "no items in list"
  | [(n, s)] -> [(n, s ^ ")")]
  | h :: t -> h :: add_close t

let rec sexp_format n s : (int * string) list =
  let flat = flat_format s in
  if String.length flat <= !pp_line_limit then [(n, flat)] else long_format n s

and long_format n s : (int * string) list =
  match s with
  | Atom s -> [(n, s)]
  | List [] -> [(n, "()")]
  | List [Atom s] -> [(n, "(" ^ s ^ ")")]
  | List (Atom s :: rest) ->
    let first = (n, s) in
    let rest' = List.concat_map (sexp_format (n + !pp_indent - 1)) rest in
    let elts = first :: rest' in
    add_open (add_close elts)
  | List lst ->
    let elts = List.concat_map (sexp_format n) lst in
    add_open (add_close elts)

let render_lines lines =
  let indent n = String.make n ' ' in
  let render_line (n, s) = indent n ^ s in
  String.concat "\n" (List.map render_line lines)

let pretty_print sexp = render_lines (sexp_format 0 sexp)

let print_sexp sexp = Printf.printf "%s\n%!" (pretty_print sexp)

let print_sexp_to_file filename sexp =
  let file = open_out filename in
  Printf.fprintf file "%s\n%!" (pretty_print sexp) ;
  close_out file

(* ---------------------------------------------------------------------- 
 * Generating unique symbols.
 * ---------------------------------------------------------------------- *)

module OrderedString = struct
  type t = string

  let compare = Stdlib.compare
end

module StringMap = Map.Make (OrderedString)

let make_gensym () =
  (* Map between symbol names and counter values (ints). *)
  let syms = ref StringMap.empty in
  (* Get a fresh name that starts with the name `v`.
   * The resulting name is the base name, the separator `sep`,
   * and an integer. *)
  let fresh ~base ~sep =
    let n =
      match StringMap.find_opt base !syms with
      | None -> 1
      | Some n -> n + 1
    in
    syms := StringMap.add base n !syms ;
    Printf.sprintf "%s%s%d" base sep n
  in
  fresh

(* ---------------------------------------------------------------------- 
 * Other utilities.
 * ---------------------------------------------------------------------- *)

let os_type () =
  let ch = Unix.open_process_in "uname -s" in
  let s = input_line ch in
  let _ = close_in ch in
  if s = "Darwin" then "MacOS" else s

let no_fix_label = ref false

let fix_label s =
  if !no_fix_label then s else if os_type () = "MacOS" then "_" ^ s else s

let failwithf f = Printf.ksprintf failwith f
