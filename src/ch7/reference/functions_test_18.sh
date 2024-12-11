(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (VecRef
          (VecRef
            (VecRef
              (VecRef
                (VecRef
                  (VecRef
                    (Apply
                      (Var e)
                      ((Vec
                         ((Apply
                            (Var h)
                            ((Apply
                               (Var t)
                               ((Apply
                                  (Var o)
                                  ((Int 1)
                                   (Vec ((Int 42)) ((Vector (Integer)))))))))))
                         ((Vector
                            ((Vector
                               ((Vector ((Vector ((Vector (Integer))))))))))))))
                    0)
                  0)
                0)
              0)
            0)
          0))))
   (Def
     o
     ((args
        ((i Integer) (v (Vector (Integer)))))
      (ret (Vector ((Vector (Integer)))))
      (body
        (If
          (Prim Eq ((Var i) (Int 0)))
          (Vec
            ((Var v))
            ((Vector ((Vector (Integer))))))
          (Let
            junk
            (Vec
              ((Vec ((Int 1)) ((Vector (Integer))))
               (Vec ((Int 2)) ((Vector (Integer))))
               (Vec ((Int 1)) ((Vector (Integer))))
               (Vec ((Int 2)) ((Vector (Integer))))
               (Vec ((Int 1)) ((Vector (Integer)))))
              ((Vector
                 ((Vector (Integer))
                  (Vector (Integer))
                  (Vector (Integer))
                  (Vector (Integer))
                  (Vector (Integer))))))
            (Apply
              (Var o)
              ((Prim
                 Add
                 ((Var i) (Prim Negate ((Int 1)))))
               (Var v))))))))
   (Def
     t
     ((args
        ((v (Vector ((Vector (Integer)))))))
      (ret
        (Vector ((Vector ((Vector (Integer)))))))
      (body
        (Vec
          ((Var v))
          ((Vector ((Vector ((Vector (Integer)))))))))))
   (Def
     h
     ((args
        ((v
           (Vector ((Vector ((Vector (Integer)))))))))
      (ret
        (Vector
          ((Vector ((Vector ((Vector (Integer)))))))))
      (body
        (Vec
          ((Var v))
          ((Vector
             ((Vector ((Vector ((Vector (Integer)))))))))))))
   (Def
     f
     ((args
        ((v
           (Vector
             ((Vector ((Vector ((Vector (Integer)))))))))))
      (ret
        (Vector
          ((Vector
             ((Vector ((Vector ((Vector (Integer)))))))))))
      (body
        (Vec
          ((Var v))
          ((Vector
             ((Vector
                ((Vector ((Vector ((Vector (Integer)))))))))))))))
   (Def
     e
     ((args
        ((v
           (Vector
             ((Vector
                ((Vector ((Vector ((Vector (Integer)))))))))))))
      (ret
        (Vector
          ((Vector
             ((Vector
                ((Vector ((Vector ((Vector (Integer)))))))))))))
      (body
        (Vec
          ((Var v))
          ((Vector
             ((Vector
                ((Vector
                   ((Vector ((Vector ((Vector (Integer)))))))))))))))))))
