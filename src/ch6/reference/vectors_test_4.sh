(Program
  (Let
    v
    (Vec ((Int 0)) (Vector (Integer)))
    (If
      (Prim Eq ((Var v) (Var v)))
      (Int 42)
      (Int 777))))
