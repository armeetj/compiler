(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (If
          (Prim
            Eq
            ((Apply (Var sum) ((Int 3))) (Int 6)))
          (Int 42)
          (Int 777)))))
   (Def
     sum
     ((args ((x Integer)))
      (ret Integer)
      (body
        (If
          (Prim Eq ((Var x) (Int 1)))
          (Int 1)
          (Prim
            Add
            ((Var x)
             (Apply
               (Var sum)
               ((Prim
                  Add
                  ((Var x) (Prim Negate ((Int 1)))))))))))))))
