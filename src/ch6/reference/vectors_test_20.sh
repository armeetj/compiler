(Program
  (Let
    a
    (Vec ((Int 777)) (Vector (Integer)))
    (Let
      b
      (Vec
        ((Var a) (Var a))
        (Vector
          ((Vector (Integer)) (Vector (Integer)))))
      (Let
        _
        (VecSet (VecRef (Var b) 0) 0 (Int 42))
        (VecRef (Var a) 0)))))
