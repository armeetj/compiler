(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Apply
          (Apply
            (Apply
              (Apply (Var rrrid) ((Int 0)))
              ((Int 0)))
            ((Int 0)))
          ((Int 42))))))
   (Def
     id
     ((args ((x Integer)))
      (ret Integer)
      (body (Var x))))
   (Def
     rid
     ((args ((x Integer)))
      (ret (Function (Integer) Integer))
      (body (Var id))))
   (Def
     rrid
     ((args ((x Integer)))
      (ret
        (Function
          (Integer)
          (Function (Integer) Integer)))
      (body (Var rid))))
   (Def
     rrrid
     ((args ((x Integer)))
      (ret
        (Function
          (Integer)
          (Function
            (Integer)
            (Function (Integer) Integer))))
      (body (Var rrid))))))
