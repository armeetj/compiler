(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Apply (Var mult) ((Int 6) (Int 7))))))
   (Def
     mult
     ((args ((x Integer) (y Integer)))
      (ret Integer)
      (body
        (If
          (Prim Eq ((Int 0) (Var x)))
          (Int 0)
          (Prim
            Add
            ((Var y)
             (Apply
               (Var mult)
               ((Prim
                  Add
                  ((Prim Negate ((Int 1))) (Var x)))
                (Var y)))))))))))
