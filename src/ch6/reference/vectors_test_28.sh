(Program
  (Let
    v
    (Vec ((Int 40)) (Vector (Integer)))
    (Let
      x
      (Vec ((Int 2)) (Vector (Integer)))
      (Prim
        Add
        ((VecRef (Var x) 0) (VecRef (Var v) 0))))))
