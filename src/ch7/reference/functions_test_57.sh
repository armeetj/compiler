(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Prim
          Add
          ((Apply (Var factorial) ((Int 0)))
           (Prim
             Add
             ((Apply (Var factorial) ((Int 1)))
              (Prim
                Add
                ((Apply (Var factorial) ((Int 2)))
                 (Prim
                   Add
                   ((Apply (Var factorial) ((Int 3)))
                    (Prim
                      Add
                      ((Apply (Var factorial) ((Int 4)))
                       (Apply (Var factorial) ((Int 5))))))))))))))))
   (Def
     mult
     ((args ((x Integer) (y Integer)))
      (ret Integer)
      (body
        (If
          (Prim Eq ((Int 0) (Var x)))
          (Int 0)
          (Prim
            Add
            ((Var y)
             (Apply
               (Var mult)
               ((Prim
                  Add
                  ((Prim Negate ((Int 1))) (Var x)))
                (Var y)))))))))
   (Def
     factorial_iter
     ((args ((n Integer) (r Integer)))
      (ret Integer)
      (body
        (If
          (Prim Eq ((Var n) (Int 0)))
          (Var r)
          (Apply
            (Var factorial_iter)
            ((Prim Sub ((Var n) (Int 1)))
             (Apply (Var mult) ((Var n) (Var r)))))))))
   (Def
     factorial
     ((args ((n Integer)))
      (ret Integer)
      (body
        (Apply
          (Var factorial_iter)
          ((Var n) (Int 1))))))))