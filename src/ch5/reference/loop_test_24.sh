(Program
  (Let
    x
    (Prim Read ())
    (Prim
      Add
      ((Var x)
       (Begin ((SetBang x (Int 40))) (Var x))))))
