(Program
  (Let
    x
    (If
      (Prim Eq ((Prim Read ()) (Int 1)))
      (Int 41)
      (Int 47))
    (Let
      v
      (Vec ((Var x)) (Vector (Integer)))
      (Prim Add ((VecRef (Var v) 0) (Int 1))))))
