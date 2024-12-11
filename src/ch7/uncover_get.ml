open Types
open Lfun_ref_alloc_get
module L = Lfun_ref_alloc
module S = VarSet

let rec collect_set_vars (e : L.exp) : VarSet.t =
  failwith "TODO"

let rec uncover_get_exp (s : S.t) (e : L.exp) : exp =
  failwith "TODO"

let uncover_get_def (s : S.t) (ldef : L.def) : def =
  let (L.Def (name, { args; ret; body })) = ldef in
  let body' = uncover_get_exp s body in
    Def (name, { args; ret; body = body' })

let uncover_get (L.Program ds) =
  let (set_vars : S.t) =
    List.fold_left
      (fun (s : S.t) (d : L.def) ->
         let (L.Def (_, fc)) = d in
           S.union s (collect_set_vars fc.body))
      S.empty
      ds
  in
    Program (List.map (uncover_get_def set_vars) ds)
