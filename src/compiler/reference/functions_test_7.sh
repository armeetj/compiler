(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Apply
          (Apply (Var id) ((Var inc)))
          ((Int 41))))))
   (Def
     id
     ((args
        ((f (Function (Integer) Integer))))
      (ret (Function (Integer) Integer))
      (body (Var f))))
   (Def
     inc
     ((args ((x Integer)))
      (ret Integer)
      (body (Prim Add ((Var x) (Int 1))))))))
