(Program
  (Begin
    ((Let
       i
       (Int 2)
       (While
         (Prim Gt ((Var i) (Int 0)))
         (SetBang i (Prim Sub ((Var i) (Int 1)))))))
    (Int 42)))
