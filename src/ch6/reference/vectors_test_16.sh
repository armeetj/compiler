(Program
  (Let
    dummy
    (Vec ((Int 0)) (Vector (Integer)))
    (Let
      f
      (Vec
        ((Vec
           ((Int 1)
            (Int 42)
            (Vec ((Bool true)) (Vector (Boolean))))
           (Vector
             (Integer Integer (Vector (Boolean)))))
         (Vec
           ((Var dummy))
           (Vector ((Vector (Integer))))))
        (Vector
          ((Vector
             (Integer Integer (Vector (Boolean))))
           (Vector ((Vector (Integer)))))))
      (VecRef (VecRef (Var f) 0) 1))))
