(Program
  (Let
    v
    (Vec
      ((Vec ((Int 0)) (Vector (Integer))))
      (Vector ((Vector (Integer)))))
    (Let
      void
      (VecSet (Var v) 0 (VecRef (Var v) 0))
      (Int 42))))
