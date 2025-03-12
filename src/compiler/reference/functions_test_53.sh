(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Prim
          Add
          ((Apply
             (Var ack)
             ((Prim Read ()) (Prim Read ())))
           (Int 41))))))
   (Def
     ack
     ((args ((m Integer) (n Integer)))
      (ret Integer)
      (body
        (If
          (Prim Eq ((Var m) (Int 0)))
          (Prim Add ((Int 1) (Var n)))
          (If
            (Prim Eq ((Var n) (Int 0)))
            (Apply
              (Var ack)
              ((Prim Sub ((Var m) (Int 1))) (Int 1)))
            (Apply
              (Var ack)
              ((Prim Sub ((Var m) (Int 1)))
               (Apply
                 (Var ack)
                 ((Var m) (Prim Sub ((Var n) (Int 1))))))))))))))
