(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Apply
          (Var fun)
          ((Int 5)
           (Int 5)
           (Int 5)
           (Int 5)
           (Int 5)
           (Int 5)
           (Int 5)
           (Int 7))))))
   (Def
     fun
     ((args
        ((x1 Integer)
         (x2 Integer)
         (x3 Integer)
         (x4 Integer)
         (x5 Integer)
         (x6 Integer)
         (x7 Integer)
         (x8 Integer)))
      (ret Integer)
      (body
        (Prim
          Add
          ((Var x1)
           (Prim
             Add
             ((Var x2)
              (Prim
                Add
                ((Var x3)
                 (Prim
                   Add
                   ((Var x4)
                    (Prim
                      Add
                      ((Var x5)
                       (Prim
                         Add
                         ((Var x6)
                          (Prim Add ((Var x7) (Var x8))))))))))))))))))))