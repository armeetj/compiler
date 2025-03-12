(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Apply
          (Var twice)
          ((Var add1) (Prim Read ()))))))
   (Def
     add1
     ((args ((y Integer)))
      (ret Integer)
      (body (Prim Add ((Int 1) (Var y))))))
   (Def
     twice
     ((args
        ((f (Function (Integer) Integer))
         (x Integer)))
      (ret Integer)
      (body
        (Prim
          Add
          ((Apply (Var f) ((Var x)))
           (Apply (Var f) ((Var x))))))))))
