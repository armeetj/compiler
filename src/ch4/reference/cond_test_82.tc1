(Program
  (Let
    y
    (If
      (Bool true)
      (Prim Read ())
      (If
        (Prim Eq ((Prim Read ()) (Int 0)))
        (Int 77)
        (Let
          x
          (Prim Read ())
          (Prim Add ((Int 1) (Var x))))))
    (Prim Add ((Var y) (Int 2)))))
