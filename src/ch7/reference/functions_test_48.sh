(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Apply (Var f) ((Int 11) (Int 10))))))
   (Def
     add
     ((args ((x Integer) (y Integer)))
      (ret (Vector (Integer)))
      (body
        (Vec
          ((Prim Add ((Var x) (Var y))))
          ((Vector (Integer)))))))
   (Def
     f
     ((args ((x Integer) (y Integer)))
      (ret Integer)
      (body
        (Let
          v
          (Vec
            ((Var x) (Var y))
            ((Vector (Integer Integer))))
          (Let
            z
            (Apply (Var add) ((Var x) (Var y)))
            (Prim
              Add
              ((Prim
                 Add
                 ((VecRef (Var v) 0) (VecRef (Var v) 1)))
               (VecRef (Var z) 0))))))))))
