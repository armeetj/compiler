(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Let
          tr
          (Apply (Var triple) ((Int 13)))
          (Prim
            Add
            ((VecRef (Var tr) 0)
             (Prim
               Add
               ((VecRef (Var tr) 1)
                (Prim Add ((VecRef (Var tr) 2) (Int 3)))))))))))
   (Def
     triple
     ((args ((x Integer)))
      (ret (Vector (Integer Integer Integer)))
      (body
        (Vec
          ((Var x) (Var x) (Var x))
          ((Vector (Integer Integer Integer)))))))))
