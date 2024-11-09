(Program
  (Let
    x
    (Prim Read ())
    (Let
      y
      (Prim Read ())
      (If
        (Prim Eq ((Var x) (Var y)))
        (Int 42)
        (Int 0)))))
