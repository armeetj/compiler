(Program
  (Let
    sum
    (Int 0)
    (Let
      i
      (Int 5)
      (Begin
        ((While
           (Prim Gt ((Var i) (Int 0)))
           (Begin
             ((SetBang
                sum
                (Prim Add ((Var sum) (Var i)))))
             (SetBang i (Prim Sub ((Var i) (Int 1)))))))
        (Prim Add ((Int 27) (Var sum)))))))
