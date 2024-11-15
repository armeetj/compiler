(Program
  (Let
    sum
    (Int 0)
    (Let
      m
      (Prim Read ())
      (Let
        n
        (Prim Read ())
        (Let
          i
          (Int 1)
          (Begin
            ((While
               (Prim Le ((Var i) (Var m)))
               (Let
                 j
                 (Int 1)
                 (Begin
                   ((While
                      (Prim Le ((Var j) (Var n)))
                      (Begin
                        ((SetBang
                           sum
                           (Prim
                             Add
                             ((Var sum) (Prim Add ((Var i) (Var j)))))))
                        (SetBang j (Prim Add ((Var j) (Int 1)))))))
                   (SetBang i (Prim Add ((Var i) (Int 1))))))))
            (Var sum)))))))
