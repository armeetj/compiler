(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (VecRef
          (Apply
            (Var map_vector)
            ((Var minus)
             (Vec ((Int 43)) ((Vector (Integer))))))
          0))))
   (Def
     minus
     ((args ((n Integer) (m Integer)))
      (ret Integer)
      (body
        (Prim
          Add
          ((Var n) (Prim Negate ((Var m))))))))
   (Def
     map_vector
     ((args
        ((f (Function (Integer Integer) Integer))
         (v (Vector (Integer)))))
      (ret (Vector (Integer)))
      (body
        (Vec
          ((Apply
             (Var f)
             ((VecRef (Var v) 0) (Int 1))))
          ((Vector (Integer)))))))))
