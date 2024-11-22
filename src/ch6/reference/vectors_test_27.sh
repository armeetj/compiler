(Program
  (Let
    v
    (Vec ((Bool true)) (Vector (Boolean)))
    (Prim
      Negate
      ((If
         (VecRef (Var v) 0)
         (Prim Negate ((Prim Read ())))
         (Prim Read ()))))))
