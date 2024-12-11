(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Let
          fun
          (Var id)
          (Apply (Var fun) ((Int 42)))))))
   (Def
     id
     ((args ((x Integer)))
      (ret Integer)
      (body (Var x))))))
