(** Definitional interpreter for the "Lfun_ref" language. *)

(* `FunRef` constructor function. *)
val fun_ref_exp : Types.label -> int -> Interp.fexp

val interp : Lfun_ref.program -> int
(** Interpreter. *)
