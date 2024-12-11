(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Apply
          (Apply (Var give_me_add1) ())
          ((Int 41))))))
   (Def
     add1
     ((args ((x Integer)))
      (ret Integer)
      (body (Prim Add ((Var x) (Int 1))))))
   (Def
     give_me_add1
     ((args ())
      (ret (Function (Integer) Integer))
      (body (Var add1))))))
