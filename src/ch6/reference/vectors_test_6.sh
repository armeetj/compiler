(Program
  (Let
    t
    (Vec
      ((Int 40)
       (Bool true)
       (Vec ((Int 2)) (Vector (Integer))))
      (Vector
        (Integer Boolean (Vector (Integer)))))
    (If
      (VecRef (Var t) 1)
      (Prim
        Add
        ((VecRef (Var t) 0)
         (VecRef (VecRef (Var t) 2) 0)))
      (Int 44))))
