(Program
  (Let
    v
    (Vec
      ((Int 0) (Int 0))
      (Vector (Integer Integer)))
    (Let
      _
      (VecSet (Var v) 0 (Int 38))
      (Let
        _
        (VecSet (Var v) 1 (Int 4))
        (Prim
          Add
          ((VecRef (Var v) 0) (VecRef (Var v) 1)))))))
