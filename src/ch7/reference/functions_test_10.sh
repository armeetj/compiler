(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (VecRef
          (Apply
            (Var map_vec)
            ((Var add1)
             (Vec
               ((Int 0) (Int 41))
               ((Vector (Integer Integer))))))
          1))))
   (Def
     map_vec
     ((args
        ((f (Function (Integer) Integer))
         (v (Vector (Integer Integer)))))
      (ret (Vector (Integer Integer)))
      (body
        (Vec
          ((Apply (Var f) ((VecRef (Var v) 0)))
           (Apply (Var f) ((VecRef (Var v) 1))))
          ((Vector (Integer Integer)))))))
   (Def
     add1
     ((args ((x Integer)))
      (ret Integer)
      (body (Prim Add ((Var x) (Int 1))))))))
