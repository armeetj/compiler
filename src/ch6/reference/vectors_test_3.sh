(Program
  (Let
    v1
    (Vec ((Int 42)) (Vector (Integer)))
    (Let
      v2
      (Vec
        ((Var v1))
        (Vector ((Vector (Integer)))))
      (VecRef (VecRef (Var v2) 0) 0))))
