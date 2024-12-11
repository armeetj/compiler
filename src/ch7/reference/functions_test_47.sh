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
        (Let
          x-vec
          (Vec ((Var x)) ((Vector (Integer))))
          (Let
            one
            (Vec ((Int 1)) ((Vector (Integer))))
            (Let
              neg-one
              (Vec
                ((Prim Negate ((Int 1))))
                ((Vector (Integer))))
              (If
                (Prim
                  Eq
                  ((VecRef (Var x-vec) 0) (Int 1)))
                (VecRef (Var one) 0)
                (Prim
                  Add
                  ((Var x)
                   (Apply
                     (Var sum)
                     ((Prim
                        Add
                        ((Var x) (VecRef (Var neg-one) 0))))))))))))))))
