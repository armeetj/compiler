(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Apply
          (Apply (Var rf) ((Int 0)))
          ((Int 42)
           (Int 1)
           (Int 2)
           (Int 3)
           (Int 4)
           (Int 5)
           (Int 6)
           (Int 7))))))
   (Def
     f
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
      (body (Var x1))))
   (Def
     rf
     ((args ((x Integer)))
      (ret
        (Function
          (Integer
            Integer
            Integer
            Integer
            Integer
            Integer
            Integer
            Integer)
          Integer))
      (body (Var f))))))
