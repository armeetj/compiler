(Program
  (Let
    M00
    (Int 1)
    (Let
      M01
      (Int 0)
      (Let
        M10
        (Int 0)
        (Let
          M11
          (Int 0)
          (Let
            i
            (Int 1)
            (Let
              j
              (Int 1)
              (Begin
                ((While
                   (Prim Lt ((Var i) (Int 2)))
                   (Begin
                     ((While
                        (Prim Lt ((Var j) (Int 2)))
                        (Begin
                          ((If
                             (Prim Eq ((Var i) (Var j)))
                             (SetBang M11 (Int 1))
                             (SetBang M11 (Var M11))))
                          (SetBang j (Prim Add ((Var j) (Int 1)))))))
                     (SetBang i (Prim Add ((Var i) (Int 1)))))))
                (Prim
                  Add
                  ((Prim
                     Add
                     ((Prim
                        Add
                        ((Prim Add ((Var M00) (Var M01)))
                         (Var M10)))
                      (Var M11)))
                   (Int 40)))))))))))
