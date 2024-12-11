(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Let
          f
          (Var id)
          (Apply (Var f) ((Int 42)))))))
   (Def
     id
     ((args ((x Integer)))
      (ret Integer)
      (body (Var x))))))
