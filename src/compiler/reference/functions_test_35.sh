(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Let
          vec
          (Vec
            ((Int 1) (Int 2) (Int 3))
            ((Vector (Integer Integer Integer))))
          (Let
            vec2
            (Apply
              (Var mapint)
              ((Var add1) (Var vec)))
            (Prim
              Add
              ((VecRef (Var vec2) 0)
               (Prim
                 Add
                 ((VecRef (Var vec2) 1)
                  (Prim
                    Add
                    ((VecRef (Var vec2) 2) (Int 33))))))))))))
   (Def
     mapint
     ((args
        ((fun (Function (Integer) Integer))
         (v (Vector (Integer Integer Integer)))))
      (ret (Vector (Integer Integer Integer)))
      (body
        (Vec
          ((Apply (Var fun) ((VecRef (Var v) 0)))
           (Apply (Var fun) ((VecRef (Var v) 1)))
           (Apply (Var fun) ((VecRef (Var v) 2))))
          ((Vector (Integer Integer Integer)))))))
   (Def
     add1
     ((args ((x Integer)))
      (ret Integer)
      (body (Prim Add ((Var x) (Int 1))))))))
