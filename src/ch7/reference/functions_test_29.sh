(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body (Apply (Var id) ((Int 42))))))
   (Def
     id
     ((args ((x Integer)))
      (ret Integer)
      (body (Prim Add ((Var x) (Int 1))))))))
