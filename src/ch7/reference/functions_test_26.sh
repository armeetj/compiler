(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Let
          v1
          (Vec ((Int 1)) ((Vector (Integer))))
          (Let
            v2
            (Vec ((Int 1)) ((Vector (Integer))))
            (Let
              v3
              (Vec ((Int 1)) ((Vector (Integer))))
              (Let
                v4
                (Vec ((Int 1)) ((Vector (Integer))))
                (Let
                  v5
                  (Vec ((Int 1)) ((Vector (Integer))))
                  (Let
                    v6
                    (Vec ((Int 1)) ((Vector (Integer))))
                    (Let
                      v7
                      (Vec ((Int 1)) ((Vector (Integer))))
                      (Let
                        v8
                        (Vec ((Int 1)) ((Vector (Integer))))
                        (Let
                          v9
                          (Vec ((Int 1)) ((Vector (Integer))))
                          (Let
                            v10
                            (Vec ((Int 1)) ((Vector (Integer))))
                            (Let
                              y
                              (Apply (Var g) ((Int 1000)))
                              (Prim
                                Add
                                ((Prim Add ((Int 32) (Var y)))
                                 (Prim
                                   Add
                                   ((VecRef (Var v1) 0)
                                    (Prim
                                      Add
                                      ((VecRef (Var v2) 0)
                                       (Prim
                                         Add
                                         ((VecRef (Var v3) 0)
                                          (Prim
                                            Add
                                            ((VecRef (Var v4) 0)
                                             (Prim
                                               Add
                                               ((VecRef (Var v5) 0)
                                                (Prim
                                                  Add
                                                  ((VecRef (Var v6) 0)
                                                   (Prim
                                                     Add
                                                     ((VecRef (Var v7) 0)
                                                      (Prim
                                                        Add
                                                        ((VecRef (Var v8) 0)
                                                         (Prim
                                                           Add
                                                           ((VecRef (Var v9) 0)
                                                            (VecRef (Var v10) 0)))))))))))))))))))))))))))))))))))
   (Def
     g
     ((args ((x Integer)))
      (ret Integer)
      (body
        (Let
          v
          (Vec ((Int 1)) ((Vector (Integer))))
          (If
            (Prim Eq ((Var x) (Int 0)))
            (Int 0)
            (Apply
              (Var g)
              ((Prim Sub ((Var x) (VecRef (Var v) 0))))))))))))