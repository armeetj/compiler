(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (If
          (Apply (Var even) ((Int 2)))
          (Int 42)
          (Int 0)))))
   (Def
     even
     ((args ((x Integer)))
      (ret Boolean)
      (body
        (If
          (Prim Eq ((Var x) (Int 0)))
          (Bool true)
          (Apply
            (Var odd)
            ((Prim
               Add
               ((Var x) (Prim Negate ((Int 1)))))))))))
   (Def
     odd
     ((args ((x Integer)))
      (ret Boolean)
      (body
        (If
          (Prim Eq ((Var x) (Int 0)))
          (Bool false)
          (Apply
            (Var even)
            ((Prim
               Add
               ((Var x) (Prim Negate ((Int 1)))))))))))))
