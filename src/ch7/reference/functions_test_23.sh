(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Prim
          Add
          ((Apply (Var f) ((Int 8)))
           (Apply
             (Var g)
             ((Int 8) (Int 0) (Int 1))))))))
   (Def
     f
     ((args ((x Integer)))
      (ret Integer)
      (body
        (If
          (Prim Eq ((Var x) (Int 0)))
          (Int 0)
          (If
            (Prim Eq ((Var x) (Int 1)))
            (Int 1)
            (Prim
              Add
              ((Apply
                 (Var f)
                 ((Prim Sub ((Var x) (Int 1)))))
               (Apply
                 (Var f)
                 ((Prim Sub ((Var x) (Int 2))))))))))))
   (Def
     g
     ((args
        ((x Integer) (y Integer) (z Integer)))
      (ret Integer)
      (body
        (If
          (Prim Eq ((Var x) (Int 0)))
          (Var y)
          (If
            (Prim Eq ((Var x) (Int 1)))
            (Var z)
            (Apply
              (Var g)
              ((Prim Sub ((Var x) (Int 1)))
               (Var z)
               (Prim Add ((Var y) (Var z))))))))))))
