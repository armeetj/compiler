(Program
  (Begin
    ()
    (Let
      x
      (Int 1)
      (Begin
        ((SetBang x (Int 2)))
        (If
          (Prim Eq ((Var x) (Int 2)))
          (Int 42)
          (Int 0))))))
