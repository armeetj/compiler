(Program
  (Let
    a
    (Vec
      ((Vec ((Int 42)) (Vector (Integer)))
       (Int 1))
      (Vector ((Vector (Integer)) Integer)))
    (Let
      b
      (VecRef (Var a) 0)
      (Let
        c
        (Var a)
        (Begin
          ((VecSet
             (Var c)
             0
             (Vec ((Int 1)) (Vector (Integer)))))
          (VecRef (Var b) 0))))))
