(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Prim
          Add
          ((Int 42)
           (Apply
             (Var big)
             ((Prim Read ())
              (Prim Read ())
              (Prim Read ()))))))))
   (Def
     big
     ((args
        ((x Integer) (y Integer) (z Integer)))
      (ret Integer)
      (body
        (Prim
          Add
          ((Prim
             Add
             ((Prim
                Add
                ((Prim Add ((Var x) (Var y)))
                 (Prim Add ((Var x) (Var z)))))
              (Prim
                Add
                ((Prim Add ((Var z) (Var x)))
                 (Prim Add ((Var z) (Var y)))))))
           (Prim
             Add
             ((Prim
                Add
                ((Prim Add ((Var y) (Var y)))
                 (Prim Add ((Var y) (Var x)))))
              (Prim
                Add
                ((Prim Add ((Var z) (Var x)))
                 (Prim Add ((Var z) (Var z))))))))))))))
