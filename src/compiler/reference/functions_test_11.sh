(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Apply
          (Var f)
          ((Int 0)
           (Vec ((Int 42)) ((Vector (Integer)))))))))
   (Def
     f
     ((args
        ((n Integer) (v (Vector (Integer)))))
      (ret Integer)
      (body
        (If
          (Prim Eq ((Var n) (Int 100)))
          (VecRef (Var v) 0)
          (Apply
            (Var f)
            ((Prim Add ((Var n) (Int 1)))
             (Vec
               ((VecRef (Var v) 0))
               ((Vector (Integer))))))))))))
