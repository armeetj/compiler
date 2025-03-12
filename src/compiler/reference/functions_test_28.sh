(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body (Apply (Var id) ((Int 0))))))
   (Def
     id
     ((args ((x Integer)))
      (ret Integer)
      (body
        (If
          (Prim Eq ((Var x) (Int 0)))
          (Int 0)
          (Int 42)))))))
