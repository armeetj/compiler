(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Prim
          Add
          ((Int 6)
           (Apply (Var g) ((Var sum_eight))))))))
   (Def
     sum_eight
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
      (body
        (Prim
          Add
          ((Prim
             Add
             ((Prim Add ((Var a) (Var b)))
              (Prim Add ((Var c) (Var d)))))
           (Prim
             Add
             ((Prim Add ((Var e) (Var f)))
              (Prim Add ((Var g) (Var h))))))))))
   (Def
     g
     ((args
        ((f
           (Function
             (Integer
               Integer
               Integer
               Integer
               Integer
               Integer
               Integer
               Integer)
             Integer))))
      (ret Integer)
      (body
        (Apply
          (Var f)
          ((Int 1)
           (Int 2)
           (Int 3)
           (Int 4)
           (Int 5)
           (Int 6)
           (Int 7)
           (Int 8))))))))