(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Apply
          (Var f)
          ((Int 0)
           (Vec
             ((Var id)
              (Vec ((Int 42)) ((Vector (Integer)))))
             ((Vector
                ((Function (Integer) Integer)
                 (Vector (Integer)))))))))))
   (Def
     id
     ((args ((x Integer)))
      (ret Integer)
      (body (Var x))))
   (Def
     f
     ((args
        ((n Integer)
         (clos
           (Vector
             ((Function (Integer) Integer)
              (Vector (Integer)))))))
      (ret Integer)
      (body
        (If
          (Prim Eq ((Var n) (Int 100)))
          (Apply
            (VecRef (Var clos) 0)
            ((VecRef (VecRef (Var clos) 1) 0)))
          (Apply
            (Var f)
            ((Prim Add ((Var n) (Int 1)))
             (Vec
               ((VecRef (Var clos) 0)
                (VecRef (Var clos) 1))
               ((Vector
                  ((Function (Integer) Integer)
                   (Vector (Integer))))))))))))))
