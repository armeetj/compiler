(Program
  (Let
    x
    (Int 42)
    (Let
      i
      (Int 2)
      (Begin
        ((While
           (Prim Lt ((Var i) (Int 0)))
           (Begin
             ((SetBang x (Prim Add ((Var x) (Int 1)))))
             (SetBang i (Prim Add ((Var x) (Int 1)))))))
        (Var x)))))
