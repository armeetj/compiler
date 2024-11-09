(Program
  (Let
    x
    (Prim Read ())
    (Let
      y
      (Prim Read ())
      (Let
        z
        (If
          (Prim Eq ((Prim Read ()) (Int 0)))
          (Prim Add ((Var x) (Int 1)))
          (Prim Add ((Var y) (Int 2))))
        (Prim
          Add
          ((Int 45) (Prim Negate ((Var z)))))))))
