(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Apply
          (Var apply)
          ((Var inc) (Prim Read ()))))))
   (Def
     apply
     ((args
        ((f (Function (Integer) Integer))
         (x Integer)))
      (ret Integer)
      (body
        (Apply
          (Var f)
          ((Apply (Var f) ((Var x))))))))
   (Def
     inc
     ((args ((x Integer)))
      (ret Integer)
      (body (Prim Add ((Var x) (Int 1))))))))