(Program
  (If
    (Bool false)
    (Let
      x
      (Int 0)
      (Begin
        ((While
           (Prim Lt ((Var x) (Int 1)))
           (Begin
             ()
             (SetBang x (Prim Add ((Var x) (Int 1)))))))
        (Var x)))
    (Int 42)))
