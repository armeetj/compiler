(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Prim
          Add
          ((Int 1) (Apply (Var id) ((Int 41))))))))
   (Def
     id
     ((args ((x Integer)))
      (ret Integer)
      (body (Var x))))))
