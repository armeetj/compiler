(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Let
          vec
          (Vec
            ((Var odd?))
            ((Vector ((Function (Integer) Boolean)))))
          (Let
            dummy
            (VecSet (Var vec) 0 (Var even?))
            (If
              (Apply (VecRef (Var vec) 0) ((Int 21)))
              (Int 999)
              (Int 42)))))))
   (Def
     even?
     ((args ((x Integer)))
      (ret Boolean)
      (body
        (If
          (Prim Eq ((Var x) (Int 0)))
          (Bool true)
          (Apply
            (Var odd?)
            ((Prim
               Add
               ((Prim Negate ((Int 1))) (Var x)))))))))
   (Def
     odd?
     ((args ((x Integer)))
      (ret Boolean)
      (body
        (If
          (Prim Eq ((Var x) (Int 0)))
          (Bool false)
          (Apply
            (Var even?)
            ((Prim
               Add
               ((Prim Negate ((Int 1))) (Var x)))))))))))
