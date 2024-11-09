(Program
  (Let
    y
    (Prim Read ())
    (Let
      x
      (If
        (Prim Eq ((Var y) (Int 0)))
        (Int 40)
        (Int 77))
      (Prim Add ((Var x) (Int 2))))))
