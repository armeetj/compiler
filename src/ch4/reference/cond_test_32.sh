(Program
  (Let
    a
    (Int 1)
    (Let
      b
      (Int 2)
      (Let
        x
        (If
          (Prim Eq ((Prim Read ()) (Int 0)))
          (Prim Negate ((Var a)))
          (Var b))
        (Prim Add ((Var x) (Int 10)))))))
