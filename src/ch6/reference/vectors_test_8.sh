(Program
  (Let
    a
    (Vec
      ((Vec ((Int 777)) (Vector (Integer)))
       (Int 98))
      (Vector ((Vector (Integer)) Integer)))
    (Let
      b
      (Vec
        ((VecRef (Var a) 0) (Int 99) (Int 100))
        (Vector
          ((Vector (Integer)) Integer Integer)))
      (Let
        _
        (VecSet (VecRef (Var b) 0) 0 (Int 42))
        (VecRef (VecRef (Var a) 0) 0)))))
