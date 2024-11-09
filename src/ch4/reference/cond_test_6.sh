(Program
  (Let
    x
    (Prim Read ())
    (If
      (Prim Eq ((Var x) (Int 0)))
      (Int 42)
      (Int 77))))
