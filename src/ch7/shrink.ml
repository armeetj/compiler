open Types
open Lfun_shrink
module L = Lfun

let rec shrink_exp (e : L.exp) : exp =
  failwith "TODO"

let shrink_def (d : L.def) : def =
  let (L.Def (name, f)) = d in
  let body' = shrink_exp f.body in
  let f' = { args = f.args; ret = f.ret; body = body' } in
    Def (name, f')

let shrink (L.Program (ds, e)) =
  let ds' = List.map shrink_def ds in
  let e'  = shrink_exp e in
  let d   = Def ("main", { args = []; ret = Integer; body = e' } ) in
    Program (d :: ds')
