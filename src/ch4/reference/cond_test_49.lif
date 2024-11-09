(Program
  (Let
    x
    (Prim Read ())
    (Let
      z
      (Prim Read ())
      (Prim
        Add
        ((If
           (Prim Eq ((Var z) (Int 0)))
           (Let
             y
             (Prim Read ())
             (Prim Add ((Var y) (Int 10))))
           (Prim Read ()))
         (Var x))))))
