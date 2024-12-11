(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body (Apply (Var uhoh) ((Int 42))))))
   (Def
     uhoh
     ((args ((x Integer)))
      (ret Integer)
      (body
        (If
          (Prim Eq ((Var x) (Int 0)))
          (Apply (Var uhoh) ((Var x)))
          (Var x)))))))
