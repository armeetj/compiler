(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Apply
          (Var f)
          ((Vec ((Int 42)) ((Vector (Integer)))))))))
   (Def
     f
     ((args ((v (Vector (Integer)))))
      (ret Integer)
      (body (VecRef (Var v) 0))))))
