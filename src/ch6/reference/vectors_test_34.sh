(Program
  (Let
    v
    (Vec ((Int 0)) (Vector (Integer)))
    (Let
      void
      (VecSet (Var v) 0 (Int 42))
      (VecRef (Var v) 0))))
