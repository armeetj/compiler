(Program
  (Let
    v
    (Vec
      ((Vec ((Int 0)) (Vector (Integer))))
      (Vector ((Vector (Integer)))))
    (Let
      v2
      (Vec ((Int 42)) (Vector (Integer)))
      (Let
        void
        (VecSet (Var v) 0 (Var v2))
        (VecRef (VecRef (Var v) 0) 0)))))
