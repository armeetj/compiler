(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Prim
          Add
          ((Apply (Var tail_sum) ((Int 5) (Int 0)))
           (Int 27))))))
   (Def
     tail_sum
     ((args ((n Integer) (r Integer)))
      (ret Integer)
      (body
        (If
          (Prim Eq ((Var n) (Int 0)))
          (Var r)
          (Apply
            (Var tail_sum)
            ((Prim Sub ((Var n) (Int 1)))
             (Prim Add ((Var n) (Var r)))))))))))
