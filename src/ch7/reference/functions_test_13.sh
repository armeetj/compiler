(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (VecRef
          (Vec
            ((Apply (Var zero) ((Int 1)))
             (Apply (Var zero) ((Int 2)))
             (Int 42))
            ((Vector
               ((Vector ()) (Vector ()) Integer))))
          2))))
   (Def
     minus
     ((args ((n Integer) (m Integer)))
      (ret Integer)
      (body
        (Prim
          Add
          ((Var n) (Prim Negate ((Var m))))))))
   (Def
     zero
     ((args ((x Integer)))
      (ret (Vector ()))
      (body
        (If
          (Prim Eq ((Var x) (Int 0)))
          (Vec () ((Vector ())))
          (Apply
            (Var zero)
            ((Prim
               Add
               ((VecRef
                  (Vec ((Var x)) ((Vector (Integer))))
                  0)
                (Prim Negate ((Int 1)))))))))))))
