(Program
  (Prim
    Add
    ((Int 1)
     (If
       (Let
         x
         (Prim Read ())
         (Prim Lt ((Int 0) (Var x))))
       (Int 41)
       (Let
         y
         (Prim Read ())
         (Prim Add ((Var y) (Int 7))))))))
