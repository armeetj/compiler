(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Let
          v
          (Vec ((Int 41)) ((Vector (Integer))))
          (Prim
            Add
            ((Apply (Var add1) ((Prim Read ())))
             (VecRef (Var v) 0)))))))
   (Def
     add1
     ((args ((x Integer)))
      (ret Integer)
      (body (Prim Add ((Var x) (Int 1))))))))
