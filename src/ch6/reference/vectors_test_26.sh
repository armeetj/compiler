(Program
  (Let
    u
    (Vec ((Int 0)) (Vector (Integer)))
    (Let
      v
      (Vec ((Int 1)) (Vector (Integer)))
      (Let
        w
        (Vec ((Int 42)) (Vector (Integer)))
        (Let
          y
          (Vec
            ((Var v))
            (Vector ((Vector (Integer)))))
          (Let
            _
            (VecSet (Var v) 0 (Int 3))
            (Let
              _
              (VecSet (Var y) 0 (Var w))
              (VecRef (VecRef (Var y) 0) 0))))))))
