(Program
  (Let
    v
    (Vec
      ((Int 4)
       (Vec
         ((Int 2)
          (Vec
            ((Int 6)
             (Vec
               ((Vec
                  ((Int 1) (Int 42))
                  (Vector (Integer Integer)))
                (Vec ((Int 3)) (Vector (Integer))))
               (Vector
                 ((Vector (Integer Integer))
                  (Vector (Integer))))))
            (Vector
              (Integer
                (Vector
                  ((Vector (Integer Integer))
                   (Vector (Integer))))))))
         (Vector
           (Integer
             (Vector
               (Integer
                 (Vector
                   ((Vector (Integer Integer))
                    (Vector (Integer))))))))))
      (Vector
        (Integer
          (Vector
            (Integer
              (Vector
                (Integer
                  (Vector
                    ((Vector (Integer Integer))
                     (Vector (Integer)))))))))))
    (VecRef
      (VecRef
        (VecRef (VecRef (VecRef (Var v) 1) 1) 1)
        0)
      1)))
