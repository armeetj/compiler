(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (If
          (Prim
            Eq
            ((Int 0)
             (Apply (Var tailrecur) ((Int 99)))))
          (Int 42)
          (Int 777)))))
   (Def
     tailrecur
     ((args ((x Integer)))
      (ret Integer)
      (body
        (If
          (Prim Eq ((Var x) (Int 0)))
          (Int 0)
          (Apply
            (Var tailrecur)
            ((Prim
               Add
               ((Var x) (Prim Negate ((Int 1)))))))))))))
