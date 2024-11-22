(Program
  (Let
    v1
    (Vec ((Int 0)) (Vector (Integer)))
    (Let
      v2
      (Vec ((Int 0)) (Vector (Integer)))
      (Let
        g1
        (Vec
          ((Int 1)
           (Int 2)
           (Int 3)
           (Int 4)
           (Int 5))
          (Vector
            (Integer
              Integer
              Integer
              Integer
              Integer)))
        (Let
          g2
          (Vec
            ((Var g1)
             (Int 2)
             (Int 3)
             (Int 4)
             (Int 5))
            (Vector
              ((Vector
                 (Integer
                   Integer
                   Integer
                   Integer
                   Integer))
               Integer
               Integer
               Integer
               Integer)))
          (Let
            g3
            (Vec
              ((Int 1)
               (Var g2)
               (Int 3)
               (Int 4)
               (Int 5))
              (Vector
                (Integer
                  (Vector
                    ((Vector
                       (Integer
                         Integer
                         Integer
                         Integer
                         Integer))
                     Integer
                     Integer
                     Integer
                     Integer))
                  Integer
                  Integer
                  Integer)))
            (Let
              g4
              (Vec
                ((Int 1)
                 (Int 2)
                 (Var g3)
                 (Int 4)
                 (Int 5))
                (Vector
                  (Integer
                    Integer
                    (Vector
                      (Integer
                        (Vector
                          ((Vector
                             (Integer
                               Integer
                               Integer
                               Integer
                               Integer))
                           Integer
                           Integer
                           Integer
                           Integer))
                        Integer
                        Integer
                        Integer))
                    Integer
                    Integer)))
              (Let
                g5
                (Vec
                  ((Int 1)
                   (Int 2)
                   (Int 3)
                   (Var g4)
                   (Int 5))
                  (Vector
                    (Integer
                      Integer
                      Integer
                      (Vector
                        (Integer
                          Integer
                          (Vector
                            (Integer
                              (Vector
                                ((Vector
                                   (Integer
                                     Integer
                                     Integer
                                     Integer
                                     Integer))
                                 Integer
                                 Integer
                                 Integer
                                 Integer))
                              Integer
                              Integer
                              Integer))
                          Integer
                          Integer))
                      Integer)))
                (Let
                  g6
                  (Vec
                    ((Int 1)
                     (Int 2)
                     (Int 3)
                     (Int 4)
                     (Var g5))
                    (Vector
                      (Integer
                        Integer
                        Integer
                        Integer
                        (Vector
                          (Integer
                            Integer
                            Integer
                            (Vector
                              (Integer
                                Integer
                                (Vector
                                  (Integer
                                    (Vector
                                      ((Vector
                                         (Integer
                                           Integer
                                           Integer
                                           Integer
                                           Integer))
                                       Integer
                                       Integer
                                       Integer
                                       Integer))
                                    Integer
                                    Integer
                                    Integer))
                                Integer
                                Integer))
                            Integer)))))
                  (Let
                    g7
                    (Vec
                      ((Int 1)
                       (Int 2)
                       (Int 3)
                       (Int 4)
                       (Int 5))
                      (Vector
                        (Integer
                          Integer
                          Integer
                          Integer
                          Integer)))
                    (Let
                      g8
                      (Vec
                        ((Int 1)
                         (Int 2)
                         (Int 3)
                         (Int 4)
                         (Int 5))
                        (Vector
                          (Integer
                            Integer
                            Integer
                            Integer
                            Integer)))
                      (Let
                        g9
                        (Vec
                          ((Int 1)
                           (Int 2)
                           (Int 3)
                           (Int 4)
                           (Int 5))
                          (Vector
                            (Integer
                              Integer
                              Integer
                              Integer
                              Integer)))
                        (Let
                          g10
                          (Vec
                            ((Int 1)
                             (Int 2)
                             (Int 3)
                             (Int 4)
                             (Int 5))
                            (Vector
                              (Integer
                                Integer
                                Integer
                                Integer
                                Integer)))
                          (Let
                            g11
                            (Vec
                              ((Int 1)
                               (Int 2)
                               (Int 3)
                               (Int 4)
                               (Int 5))
                              (Vector
                                (Integer
                                  Integer
                                  Integer
                                  Integer
                                  Integer)))
                            (Let
                              g12
                              (Vec
                                ((Int 1)
                                 (Int 2)
                                 (Int 3)
                                 (Int 4)
                                 (Int 5))
                                (Vector
                                  (Integer
                                    Integer
                                    Integer
                                    Integer
                                    Integer)))
                              (Let
                                g13
                                (Vec
                                  ((Int 1)
                                   (Int 2)
                                   (Int 3)
                                   (Int 4)
                                   (Int 5))
                                  (Vector
                                    (Integer
                                      Integer
                                      Integer
                                      Integer
                                      Integer)))
                                (Let
                                  g14
                                  (Vec
                                    ((Int 1)
                                     (Int 2)
                                     (Int 3)
                                     (Int 4)
                                     (Int 5))
                                    (Vector
                                      (Integer
                                        Integer
                                        Integer
                                        Integer
                                        Integer)))
                                  (Let
                                    dummy
                                    (If
                                      (Prim Eq ((Prim Read ()) (Int 0)))
                                      (Let
                                        d2
                                        (VecSet (Var v1) 0 (Int 42))
                                        (VecSet (Var v2) 0 (VecRef (Var v1) 0)))
                                      (VecSet (Var v2) 0 (Int 99)))
                                    (VecRef (Var v2) 0)))))))))))))))))))
