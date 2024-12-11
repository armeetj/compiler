(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (If
          (Apply (Var g) ())
          (Apply (Var h) ())
          (Apply (Var l) ((Apply (Var k) ())))))))
   (Def
     g
     ((args ())
      (ret Boolean)
      (body (Bool false))))
   (Def
     h
     ((args ())
      (ret Integer)
      (body (Int 777))))
   (Def
     k
     ((args ())
      (ret Integer)
      (body (Int 41))))
   (Def
     l
     ((args ((y Integer)))
      (ret Integer)
      (body (Prim Add ((Var y) (Int 1))))))))
