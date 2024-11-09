(Program
  (If
    (Prim Eq ((Int 1) (Int 0)))
    (Int 777)
    (Prim
      Add
      ((Int 2)
       (If
         (Prim
           Eq
           ((Prim Add ((Int 1) (Int 1))) (Int 2)))
         (Int 40)
         (Int 444))))))
