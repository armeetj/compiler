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
                (Vec
                  ((Apply (Var zero) ((Int 20)))
                   (Int 42)
                   (Apply (Var one) ((Int 20)))
                   (Apply (Var two) ((Int 20)))
                   (Apply (Var three) ((Int 20))))
                  ((Vector
                     ((Vector ())
                      Integer
                      (Vector ((Vector ()) Integer))
                      (Vector
                        ((Vector ())
                         Integer
                         (Vector ((Vector ()) Integer))))
                      (Vector
                        ((Vector ())
                         Integer
                         (Vector ((Vector ()) Integer))
                         (Vector
                           ((Vector ())
                            Integer
                            (Vector ((Vector ()) Integer))))))))))
                4)
              3)
            2)
          1))))
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
            ((Apply
               (Var minus)
               ((VecRef
                  (Vec ((Var x)) ((Vector (Integer))))
                  0)
                (Int 1)))))))))
   (Def
     one
     ((args ((x Integer)))
      (ret (Vector ((Vector ()) Integer)))
      (body
        (If
          (Prim Eq ((Var x) (Int 0)))
          (Vec
            ((Apply (Var zero) ((Int 20))) (Int 42))
            ((Vector ((Vector ()) Integer))))
          (Apply
            (Var one)
            ((Apply
               (Var minus)
               ((VecRef
                  (Vec ((Var x)) ((Vector (Integer))))
                  0)
                (Int 1)))))))))
   (Def
     two
     ((args ((x Integer)))
      (ret
        (Vector
          ((Vector ())
           Integer
           (Vector ((Vector ()) Integer)))))
      (body
        (If
          (Prim Eq ((Var x) (Int 0)))
          (Vec
            ((Apply (Var zero) ((Int 20)))
             (Int 42)
             (Apply (Var one) ((Int 20))))
            ((Vector
               ((Vector ())
                Integer
                (Vector ((Vector ()) Integer))))))
          (Apply
            (Var two)
            ((Apply
               (Var minus)
               ((VecRef
                  (Vec ((Var x)) ((Vector (Integer))))
                  0)
                (Int 1)))))))))
   (Def
     three
     ((args ((x Integer)))
      (ret
        (Vector
          ((Vector ())
           Integer
           (Vector ((Vector ()) Integer))
           (Vector
             ((Vector ())
              Integer
              (Vector ((Vector ()) Integer)))))))
      (body
        (If
          (Prim Eq ((Var x) (Int 0)))
          (Vec
            ((Apply (Var zero) ((Int 20)))
             (Int 42)
             (Apply (Var one) ((Int 20)))
             (Apply (Var two) ((Int 20))))
            ((Vector
               ((Vector ())
                Integer
                (Vector ((Vector ()) Integer))
                (Vector
                  ((Vector ())
                   Integer
                   (Vector ((Vector ()) Integer))))))))
          (Apply
            (Var three)
            ((Apply
               (Var minus)
               ((VecRef
                  (Vec ((Var x)) ((Vector (Integer))))
                  0)
                (Int 1)))))))))))
