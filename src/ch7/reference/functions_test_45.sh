(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Let
          a
          (Apply
            (Var big)
            ((Int 1)
             (Int 2)
             (Int 3)
             (Int 0)
             (Int 5)
             (Int 6)
             (Int 7)
             (Int 8)
             (Int 9)
             (Int 1)))
          (Let
            b
            (Int 1)
            (Let
              c
              (Int 1)
              (Let
                d
                (Int 1)
                (Let
                  e
                  (Int 1)
                  (Let
                    f
                    (Int 1)
                    (Let
                      g
                      (Int 1)
                      (Let
                        h
                        (Int 1)
                        (Let
                          i
                          (Int 1)
                          (Let
                            j
                            (Int 1)
                            (Let
                              k
                              (Int 1)
                              (Let
                                l
                                (Int 1)
                                (Let
                                  m
                                  (Int 1)
                                  (Let
                                    n
                                    (Int 1)
                                    (Let
                                      o
                                      (Int 1)
                                      (Let
                                        p
                                        (Int 1)
                                        (Let
                                          q
                                          (Int 1)
                                          (Let
                                            r
                                            (Int 1)
                                            (Let
                                              s
                                              (Apply
                                                (Var big2)
                                                ((Int 1)
                                                 (Int 2)
                                                 (Int 3)
                                                 (Int 1)
                                                 (Int 5)
                                                 (Int 6)
                                                 (Int 7)
                                                 (Int 0)))
                                              (Let
                                                t
                                                (Int 1)
                                                (Let
                                                  u
                                                  (Int 1)
                                                  (Prim
                                                    Add
                                                    ((Var a)
                                                     (Prim
                                                       Add
                                                       ((Var b)
                                                        (Prim
                                                          Add
                                                          ((Var c)
                                                           (Prim
                                                             Add
                                                             ((Var d)
                                                              (Prim
                                                                Add
                                                                ((Var e)
                                                                 (Prim
                                                                   Add
                                                                   ((Var f)
                                                                    (Prim
                                                                      Add
                                                                      ((Var g)
                                                                       (Prim
                                                                         Add
                                                                         ((Var h)
                                                                          (Prim
                                                                            Add
                                                                            ((Var i)
                                                                             (Prim
                                                                               Add
                                                                               ((Var j)
                                                                                (Prim
                                                                                  Add
                                                                                  ((Var k)
                                                                                   (Prim
                                                                                     Add
                                                                                     ((Var l)
                                                                                      (Prim
                                                                                        Add
                                                                                        ((Var m)
                                                                                         (Prim
                                                                                           Add
                                                                                           ((Var n)
                                                                                            (Prim
                                                                                              Add
                                                                                              ((Var o)
                                                                                               (Prim
                                                                                                 Add
                                                                                                 ((Var p)
                                                                                                  (Prim
                                                                                                    Add
                                                                                                    ((Var q)
                                                                                                     (Prim
                                                                                                       Add
                                                                                                       ((Var r)
                                                                                                        (Prim
                                                                                                          Add
                                                                                                          ((Var s)
                                                                                                           (Prim
                                                                                                             Add
                                                                                                             ((Var t) (Prim Add ((Var u) (Int 21)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
   (Def
     big
     ((args
        ((a Integer)
         (b Integer)
         (c Integer)
         (d Integer)
         (e Integer)
         (f Integer)
         (g Integer)
         (h Integer)
         (i Integer)
         (j Integer)))
      (ret Integer)
      (body (Prim Add ((Var d) (Var j))))))
   (Def
     big2
     ((args
        ((a Integer)
         (b Integer)
         (c Integer)
         (d Integer)
         (e Integer)
         (f Integer)
         (g Integer)
         (h Integer)))
      (ret Integer)
      (body (Prim Add ((Var d) (Var h))))))))
