(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Apply
          (Var foo)
          ((Int 100)
           (Int 2)
           (Int 3)
           (Int 4)
           (Int 5)
           (Int 6)
           (Int 7)
           (Int 8)
           (Int 142))))))
   (Def
     foo
     ((args
        ((x1 Integer)
         (x2 Integer)
         (x3 Integer)
         (x4 Integer)
         (x5 Integer)
         (x6 Integer)
         (x7 Integer)
         (x8 Integer)
         (x9 Integer)))
      (ret Integer)
      (body
        (If
          (Prim Eq ((Int 0) (Var x1)))
          (Var x9)
          (Apply
            (Var foo)
            ((Prim
               Add
               ((Var x1) (Prim Negate ((Int 1)))))
             (Var x2)
             (Var x3)
             (Var x4)
             (Var x5)
             (Var x6)
             (Var x7)
             (Var x8)
             (Prim
               Add
               ((Var x9) (Prim Negate ((Int 1)))))))))))))