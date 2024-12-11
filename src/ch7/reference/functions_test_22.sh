(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Apply
          (Var h)
          ((Int 1)
           (Int 2)
           (Int 3)
           (Int 4)
           (Int 5)
           (Int 6)
           (Int 7))))))
   (Def
     h
     ((args
        ((a Integer)
         (b Integer)
         (c Integer)
         (d Integer)
         (e Integer)
         (f Integer)
         (g Integer)))
      (ret Integer)
      (body
        (Prim
          Add
          ((Var a)
           (Prim
             Add
             ((Var b)
              (Prim
                Add
                ((Var c)
                 (Prim
                   Add
                   ((Var d)
                    (Prim
                      Add
                      ((Var e) (Prim Add ((Var f) (Var g))))))))))))))))))
