(Program
  (Let
    x
    (Prim Read ())
    (Begin
      ((While
         (Prim Gt ((Var x) (Int 0)))
         (SetBang x (Prim Sub ((Var x) (Int 2))))))
      (Prim Add ((Var x) (Int 42))))))
