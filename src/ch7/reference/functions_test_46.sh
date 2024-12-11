(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body (Apply (Var sub1) ((Int 43))))))
   (Def
     sub1
     ((args ((x Integer)))
      (ret Integer)
      (body (Prim Sub ((Var x) (Int 1))))))))
