(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Let
          a
          (Apply
            (Var big)
            ((Int 1)
             (Int 2)
             (Int 3)
             (Int 10)
             (Int 5)
             (Int 6)
             (Int 7)
             (Int 8)
             (Int 9)
             (Int 11)))
          (Let
            b
            (Apply
              (Var big2)
              ((Int 1)
               (Int 2)
               (Int 3)
               (Int 10)
               (Int 5)
               (Int 6)
               (Int 7)
               (Int 11)))
            (Prim Add ((Var a) (Var b))))))))
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
      (body (Prim Add ((Var d) (Var j))))))
   (Def
     big2
     ((args
        ((a Integer)
         (b Integer)
         (c Integer)
         (d Integer)
         (e Integer)
         (f Integer)
         (g Integer)
         (h Integer)))
      (ret Integer)
      (body (Prim Add ((Var d) (Var h))))))))
