(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Apply
          (Var id2)
          ((Apply (Var id) ((Int 42))))))))
   (Def
     id
     ((args ((x Integer)))
      (ret Integer)
      (body (Var x))))
   (Def
     id2
     ((args ((y Integer)))
      (ret Integer)
      (body (Var y))))))
