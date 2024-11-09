(Program
  (Let
    x
    (Prim Read ())
    (Let
      y
      (Prim Read ())
      (Let
        z
        (Prim Read ())
        (Let
          w
          (Prim Add ((Var z) (Var z)))
          (Prim
            Add
            ((Var w)
             (If
               (Prim Eq ((Var z) (Int 0)))
               (Var x)
               (Var y)))))))))
