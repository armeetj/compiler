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
                      ((Int 20)
                       (Apply
                         (Var f)
                         ((Int 20)
                          (Apply
                            (Var h)
                            ((Int 20)
                             (Apply
                               (Var t)
                               ((Int 20)
                                (Apply
                                  (Var o)
                                  ((Int 20) (Apply (Var z) ((Int 20)))))))))))))
                    0)
                  0)
                0)
              0)
            0)
          0))))
   (Def
     minus
     ((args ((m Integer) (n Integer)))
      (ret Integer)
      (body
        (Prim
          Add
          ((Var m) (Prim Negate ((Var n))))))))
   (Def
     z
     ((args ((i Integer)))
      (ret (Vector (Integer)))
      (body
        (If
          (Prim Eq ((Var i) (Int 0)))
          (Vec ((Int 42)) ((Vector (Integer))))
          (Let
            junk
            (Vec
              ((Vec ((Int 1)) ((Vector (Integer))))
               (Vec ((Int 2)) ((Vector (Integer))))
               (Vec ((Int 3)) ((Vector (Integer))))
               (Vec ((Int 4)) ((Vector (Integer))))
               (Vec ((Int 5)) ((Vector (Integer)))))
              ((Vector
                 ((Vector (Integer))
                  (Vector (Integer))
                  (Vector (Integer))
                  (Vector (Integer))
                  (Vector (Integer))))))
            (Let
              garbage
              (Vec
                ((Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1))
                ((Vector
                   (Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer))))
              (Let
                more
                (Vec
                  ((Var junk)
                   (Var garbage)
                   (Var junk)
                   (Var garbage)
                   (Var junk)
                   (Var garbage)
                   (Var junk)
                   (Var garbage))
                  ((Vector
                     ((Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))
                      (Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))
                      (Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))
                      (Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))))))
                (Apply
                  (Var z)
                  ((Apply (Var minus) ((Var i) (Int 1))))))))))))
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
               (Vec ((Int 3)) ((Vector (Integer))))
               (Vec ((Int 4)) ((Vector (Integer))))
               (Vec ((Int 5)) ((Vector (Integer)))))
              ((Vector
                 ((Vector (Integer))
                  (Vector (Integer))
                  (Vector (Integer))
                  (Vector (Integer))
                  (Vector (Integer))))))
            (Let
              garbage
              (Vec
                ((Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1))
                ((Vector
                   (Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer))))
              (Let
                more
                (Vec
                  ((Var junk)
                   (Var garbage)
                   (Var junk)
                   (Var garbage)
                   (Var junk)
                   (Var garbage)
                   (Var junk)
                   (Var garbage))
                  ((Vector
                     ((Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))
                      (Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))
                      (Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))
                      (Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))))))
                (Apply
                  (Var o)
                  ((Apply (Var minus) ((Var i) (Int 1)))
                   (Var v))))))))))
   (Def
     t
     ((args
        ((i Integer)
         (v (Vector ((Vector (Integer)))))))
      (ret
        (Vector ((Vector ((Vector (Integer)))))))
      (body
        (If
          (Prim Eq ((Var i) (Int 0)))
          (Vec
            ((Var v))
            ((Vector ((Vector ((Vector (Integer))))))))
          (Let
            junk
            (Vec
              ((Vec ((Int 1)) ((Vector (Integer))))
               (Vec ((Int 2)) ((Vector (Integer))))
               (Vec ((Int 3)) ((Vector (Integer))))
               (Vec ((Int 4)) ((Vector (Integer))))
               (Vec ((Int 5)) ((Vector (Integer)))))
              ((Vector
                 ((Vector (Integer))
                  (Vector (Integer))
                  (Vector (Integer))
                  (Vector (Integer))
                  (Vector (Integer))))))
            (Let
              garbage
              (Vec
                ((Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1))
                ((Vector
                   (Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer))))
              (Let
                more
                (Vec
                  ((Var junk)
                   (Var garbage)
                   (Var junk)
                   (Var garbage)
                   (Var junk)
                   (Var garbage)
                   (Var junk)
                   (Var garbage))
                  ((Vector
                     ((Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))
                      (Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))
                      (Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))
                      (Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))))))
                (Apply
                  (Var t)
                  ((Apply (Var minus) ((Var i) (Int 1)))
                   (Var v))))))))))
   (Def
     h
     ((args
        ((i Integer)
         (v
           (Vector ((Vector ((Vector (Integer)))))))))
      (ret
        (Vector
          ((Vector ((Vector ((Vector (Integer)))))))))
      (body
        (If
          (Prim Eq ((Var i) (Int 0)))
          (Vec
            ((Var v))
            ((Vector
               ((Vector ((Vector ((Vector (Integer))))))))))
          (Let
            junk
            (Vec
              ((Vec ((Int 1)) ((Vector (Integer))))
               (Vec ((Int 2)) ((Vector (Integer))))
               (Vec ((Int 3)) ((Vector (Integer))))
               (Vec ((Int 4)) ((Vector (Integer))))
               (Vec ((Int 5)) ((Vector (Integer)))))
              ((Vector
                 ((Vector (Integer))
                  (Vector (Integer))
                  (Vector (Integer))
                  (Vector (Integer))
                  (Vector (Integer))))))
            (Let
              garbage
              (Vec
                ((Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1))
                ((Vector
                   (Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer))))
              (Let
                more
                (Vec
                  ((Var junk)
                   (Var garbage)
                   (Var junk)
                   (Var garbage)
                   (Var junk)
                   (Var garbage)
                   (Var junk)
                   (Var garbage))
                  ((Vector
                     ((Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))
                      (Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))
                      (Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))
                      (Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))))))
                (Apply
                  (Var h)
                  ((Apply (Var minus) ((Var i) (Int 1)))
                   (Var v))))))))))
   (Def
     f
     ((args
        ((i Integer)
         (v
           (Vector
             ((Vector ((Vector ((Vector (Integer)))))))))))
      (ret
        (Vector
          ((Vector
             ((Vector ((Vector ((Vector (Integer)))))))))))
      (body
        (If
          (Prim Eq ((Var i) (Int 0)))
          (Vec
            ((Var v))
            ((Vector
               ((Vector
                  ((Vector ((Vector ((Vector (Integer))))))))))))
          (Let
            junk
            (Vec
              ((Vec ((Int 1)) ((Vector (Integer))))
               (Vec ((Int 2)) ((Vector (Integer))))
               (Vec ((Int 3)) ((Vector (Integer))))
               (Vec ((Int 4)) ((Vector (Integer))))
               (Vec ((Int 5)) ((Vector (Integer)))))
              ((Vector
                 ((Vector (Integer))
                  (Vector (Integer))
                  (Vector (Integer))
                  (Vector (Integer))
                  (Vector (Integer))))))
            (Let
              garbage
              (Vec
                ((Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1))
                ((Vector
                   (Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer))))
              (Let
                more
                (Vec
                  ((Var junk)
                   (Var garbage)
                   (Var junk)
                   (Var garbage)
                   (Var junk)
                   (Var garbage)
                   (Var junk)
                   (Var garbage))
                  ((Vector
                     ((Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))
                      (Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))
                      (Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))
                      (Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))))))
                (Apply
                  (Var f)
                  ((Apply (Var minus) ((Var i) (Int 1)))
                   (Var v))))))))))
   (Def
     e
     ((args
        ((i Integer)
         (v
           (Vector
             ((Vector
                ((Vector ((Vector ((Vector (Integer)))))))))))))
      (ret
        (Vector
          ((Vector
             ((Vector
                ((Vector ((Vector ((Vector (Integer)))))))))))))
      (body
        (If
          (Prim Eq ((Var i) (Int 0)))
          (Vec
            ((Var v))
            ((Vector
               ((Vector
                  ((Vector
                     ((Vector ((Vector ((Vector (Integer))))))))))))))
          (Let
            junk
            (Vec
              ((Vec ((Int 1)) ((Vector (Integer))))
               (Vec ((Int 2)) ((Vector (Integer))))
               (Vec ((Int 3)) ((Vector (Integer))))
               (Vec ((Int 4)) ((Vector (Integer))))
               (Vec ((Int 5)) ((Vector (Integer)))))
              ((Vector
                 ((Vector (Integer))
                  (Vector (Integer))
                  (Vector (Integer))
                  (Vector (Integer))
                  (Vector (Integer))))))
            (Let
              garbage
              (Vec
                ((Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1)
                 (Int -1))
                ((Vector
                   (Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer
                     Integer))))
              (Let
                more
                (Vec
                  ((Var junk)
                   (Var garbage)
                   (Var junk)
                   (Var garbage)
                   (Var junk)
                   (Var garbage)
                   (Var junk)
                   (Var garbage))
                  ((Vector
                     ((Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))
                      (Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))
                      (Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))
                      (Vector
                        ((Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))
                         (Vector (Integer))))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer
                          Integer))))))
                (Apply
                  (Var e)
                  ((Apply (Var minus) ((Var i) (Int 1)))
                   (Var v))))))))))))
