(Program
  (Let
    v
    (Vec
      ((Vec ((Int 0)) (Vector (Integer))))
      (Vector ((Vector (Integer)))))
    (Let
      void
      (VecSet (VecRef (Var v) 0) 0 (Int 42))
      (VecRef (VecRef (Var v) 0) 0))))
