(Program
  (If
    (Bool true)
    (Int 42)
    (Let
      x
      (Prim Read ())
      (Prim Add ((Var x) (Var x))))))
