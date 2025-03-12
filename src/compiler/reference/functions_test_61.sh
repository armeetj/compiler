(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Apply
          (Var h)
          ((Int 0)
           (Int 0)
           (Int 0)
           (Int 0)
           (Int 0)
           (Int 1)
           (Int 0))))))
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
