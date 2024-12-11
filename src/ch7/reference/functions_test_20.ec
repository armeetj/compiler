(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.4 (FunRef (Label foo) 6))
            (Seq
              (Assign $tmp.1 (GlobalVal free_ptr))
              (Seq
                (Assign
                  $tmp.2
                  (Prim Add ((Var $tmp.1) (Int 40))))
                (Seq
                  (Assign
                    $tmp.3
                    (GlobalVal fromspace_end))
                  (IfStmt
                    (op Lt)
                    (arg1 (Var $tmp.2))
                    (arg2 (Var $tmp.3))
                    (jump_then (Label block_2))
                    (jump_else (Label block_3))))))))
         ((Label block_1)
          (Seq
            (Assign
              $ea.1
              (Allocate
                4
                (Vector
                  (Integer Integer Integer Integer))))
            (Seq
              (Assign
                _.4
                (VecSet (Var $ea.1) 0 (Int 6)))
              (Seq
                (Assign
                  _.3
                  (VecSet (Var $ea.1) 1 (Int 7)))
                (Seq
                  (Assign
                    _.2
                    (VecSet (Var $ea.1) 2 (Int 8)))
                  (Seq
                    (Assign
                      _.1
                      (VecSet (Var $ea.1) 3 (Int 142)))
                    (TailCall
                      (Var $tmp.4)
                      ((Int 100)
                       (Int 2)
                       (Int 3)
                       (Int 4)
                       (Int 5)
                       (Var $ea.1)))))))))
         ((Label block_2)
          (Seq
            (Assign _.5 (Atm Void))
            (Goto (Label block_1))))
         ((Label block_3)
          (Seq
            (Collect 40)
            (Goto (Label block_1))))))))
   (Def
     (Label foo)
     ((args
        ((x1.1 Integer)
         (x2.1 Integer)
         (x3.1 Integer)
         (x4.1 Integer)
         (x5.1 Integer)
         ($tup.1
           (Vector
             (Integer Integer Integer Integer)))))
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Int 0))
            (arg2 (Var x1.1))
            (jump_then (Label block_7))
            (jump_else (Label block_8))))
         ((Label block_4)
          (Seq
            (Assign
              $ea.6
              (Allocate
                4
                (Vector
                  (Integer Integer Integer Integer))))
            (Seq
              (Assign
                _.9
                (VecSet (Var $ea.6) 0 (Var $ea.2)))
              (Seq
                (Assign
                  _.8
                  (VecSet (Var $ea.6) 1 (Var $ea.3)))
                (Seq
                  (Assign
                    _.7
                    (VecSet (Var $ea.6) 2 (Var $ea.4)))
                  (Seq
                    (Assign
                      _.6
                      (VecSet (Var $ea.6) 3 (Var $ea.5)))
                    (TailCall
                      (Var $tmp.12)
                      ((Var $tmp.6)
                       (Var x2.1)
                       (Var x3.1)
                       (Var x4.1)
                       (Var x5.1)
                       (Var $ea.6)))))))))
         ((Label block_5)
          (Seq
            (Assign _.10 (Atm Void))
            (Goto (Label block_4))))
         ((Label block_6)
          (Seq
            (Collect 40)
            (Goto (Label block_4))))
         ((Label block_7)
          (Return (VecRef (Var $tup.1) 3)))
         ((Label block_8)
          (Seq
            (Assign $tmp.12 (FunRef (Label foo) 6))
            (Seq
              (Assign $tmp.5 (Prim Negate ((Int 1))))
              (Seq
                (Assign
                  $tmp.6
                  (Prim Add ((Var x1.1) (Var $tmp.5))))
                (Seq
                  (Assign $ea.2 (VecRef (Var $tup.1) 0))
                  (Seq
                    (Assign $ea.3 (VecRef (Var $tup.1) 1))
                    (Seq
                      (Assign $ea.4 (VecRef (Var $tup.1) 2))
                      (Seq
                        (Assign $tmp.7 (VecRef (Var $tup.1) 3))
                        (Seq
                          (Assign $tmp.8 (Prim Negate ((Int 1))))
                          (Seq
                            (Assign
                              $ea.5
                              (Prim Add ((Var $tmp.7) (Var $tmp.8))))
                            (Seq
                              (Assign $tmp.9 (GlobalVal free_ptr))
                              (Seq
                                (Assign
                                  $tmp.10
                                  (Prim Add ((Var $tmp.9) (Int 40))))
                                (Seq
                                  (Assign
                                    $tmp.11
                                    (GlobalVal fromspace_end))
                                  (IfStmt
                                    (op Lt)
                                    (arg1 (Var $tmp.10))
                                    (arg2 (Var $tmp.11))
                                    (jump_then (Label block_5))
                                    (jump_else (Label block_6))))))))))))))))))))))
