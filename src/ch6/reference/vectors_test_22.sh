(Program
  (Let
    v
    (Vec
      ((Vec ((Int 44)) (Vector (Integer))))
      (Vector ((Vector (Integer)))))
    (Let
      x
      (Let
        w
        (Vec ((Int 42)) (Vector (Integer)))
        (Let
          _
          (VecSet (Var v) 0 (Var w))
          (Int 0)))
      (Prim
        Add
        ((Var x) (VecRef (VecRef (Var v) 0) 0))))))
