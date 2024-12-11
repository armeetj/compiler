(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Apply (Var add) ((Int 40) (Int 2))))))
   (Def
     add
     ((args ((x Integer) (y Integer)))
      (ret Integer)
      (body (Prim Add ((Var x) (Var y))))))))
