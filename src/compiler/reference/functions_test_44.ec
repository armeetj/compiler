(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.4 (FunRef (Label big) 6))
            (Seq
              (Assign $tmp.1 (GlobalVal free_ptr))
              (Seq
                (Assign
                  $tmp.2
                  (Prim Add ((Var $tmp.1) (Int 48))))
                (Seq
                  (Assign
                    $tmp.3
                    (GlobalVal fromspace_end))
                  (IfStmt
                    (op Lt)
                    (arg1 (Var $tmp.2))
                    (arg2 (Var $tmp.3))
                    (jump_then (Label block_5))
                    (jump_else (Label block_6))))))))
         ((Label block_1)
          (Seq
            (Assign
              $ea.2
              (Allocate
                3
                (Vector (Integer Integer Integer))))
            (Seq
              (Assign
                _.9
                (VecSet (Var $ea.2) 0 (Int 6)))
              (Seq
                (Assign
                  _.8
                  (VecSet (Var $ea.2) 1 (Int 7)))
                (Seq
                  (Assign
                    _.7
                    (VecSet (Var $ea.2) 2 (Int 11)))
                  (Seq
                    (Assign
                      b.1
                      (Call
                        (Var $tmp.8)
                        ((Int 1)
                         (Int 2)
                         (Int 3)
                         (Int 10)
                         (Int 5)
                         (Var $ea.2))))
                    (Return
                      (Prim Add ((Var a.1) (Var b.1))))))))))
         ((Label block_2)
          (Seq
            (Assign _.10 (Atm Void))
            (Goto (Label block_1))))
         ((Label block_3)
          (Seq
            (Collect 32)
            (Goto (Label block_1))))
         ((Label block_4)
          (Seq
            (Assign
              $ea.1
              (Allocate
                5
                (Vector
                  (Integer
                    Integer
                    Integer
                    Integer
                    Integer))))
            (Seq
              (Assign
                _.5
                (VecSet (Var $ea.1) 0 (Int 6)))
              (Seq
                (Assign
                  _.4
                  (VecSet (Var $ea.1) 1 (Int 7)))
                (Seq
                  (Assign
                    _.3
                    (VecSet (Var $ea.1) 2 (Int 8)))
                  (Seq
                    (Assign
                      _.2
                      (VecSet (Var $ea.1) 3 (Int 9)))
                    (Seq
                      (Assign
                        _.1
                        (VecSet (Var $ea.1) 4 (Int 11)))
                      (Seq
                        (Assign
                          a.1
                          (Call
                            (Var $tmp.4)
                            ((Int 1)
                             (Int 2)
                             (Int 3)
                             (Int 10)
                             (Int 5)
                             (Var $ea.1))))
                        (Seq
                          (Assign $tmp.8 (FunRef (Label big2) 6))
                          (Seq
                            (Assign $tmp.5 (GlobalVal free_ptr))
                            (Seq
                              (Assign
                                $tmp.6
                                (Prim Add ((Var $tmp.5) (Int 32))))
                              (Seq
                                (Assign
                                  $tmp.7
                                  (GlobalVal fromspace_end))
                                (IfStmt
                                  (op Lt)
                                  (arg1 (Var $tmp.6))
                                  (arg2 (Var $tmp.7))
                                  (jump_then (Label block_2))
                                  (jump_else (Label block_3)))))))))))))))
         ((Label block_5)
          (Seq
            (Assign _.6 (Atm Void))
            (Goto (Label block_4))))
         ((Label block_6)
          (Seq
            (Collect 48)
            (Goto (Label block_4))))))))
   (Def
     (Label big)
     ((args
        ((a.2 Integer)
         (b.2 Integer)
         (c.1 Integer)
         (d.1 Integer)
         (e.1 Integer)
         ($tup.1
           (Vector
             (Integer
               Integer
               Integer
               Integer
               Integer)))))
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.9 (VecRef (Var $tup.1) 4))
            (Return
              (Prim Add ((Var d.1) (Var $tmp.9))))))))))
   (Def
     (Label big2)
     ((args
        ((a.3 Integer)
         (b.3 Integer)
         (c.2 Integer)
         (d.2 Integer)
         (e.2 Integer)
         ($tup.2
           (Vector (Integer Integer Integer)))))
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.10 (VecRef (Var $tup.2) 2))
            (Return
              (Prim Add ((Var d.2) (Var $tmp.10))))))))))))
