(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Apply
          (Var m)
          ((Int 777)
           (Int 776)
           (Int 775)
           (Int 774)
           (Int 773)
           (Int 772)
           (Int 771)
           (Int 770)
           (Int 42))))))
   (Def
     m
     ((args
        ((a Integer)
         (b Integer)
         (c Integer)
         (d Integer)
         (e Integer)
         (f Integer)
         (g Integer)
         (h Integer)
         (i Integer)))
      (ret Integer)
      (body (Var i))))))
