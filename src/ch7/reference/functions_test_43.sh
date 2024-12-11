(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Apply
          (Var big)
          ((Int 1)
           (Int 2)
           (Int 3)
           (Int 20)
           (Int 5)
           (Int 6)
           (Int 7)
           (Int 8)
           (Int 9)
           (Int 22))))))
   (Def
     big
     ((args
        ((a Integer)
         (b Integer)
         (c Integer)
         (d Integer)
         (e Integer)
         (f Integer)
         (g Integer)
         (h Integer)
         (i Integer)
         (j Integer)))
      (ret Integer)
      (body (Prim Add ((Var d) (Var j))))))))
