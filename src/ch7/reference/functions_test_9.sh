(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Apply (Var add) ((Int 20) (Int 22))))))
   (Def
     add
     ((args ((x Integer) (y Integer)))
      (ret Integer)
      (body (Prim Add ((Var x) (Var y))))))))
