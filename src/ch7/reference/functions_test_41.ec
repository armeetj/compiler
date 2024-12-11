(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.1 (GlobalVal free_ptr))
            (Seq
              (Assign
                $tmp.2
                (Prim Add ((Var $tmp.1) (Int 32))))
              (Seq
                (Assign
                  $tmp.3
                  (GlobalVal fromspace_end))
                (IfStmt
                  (op Lt)
                  (arg1 (Var $tmp.2))
                  (arg2 (Var $tmp.3))
                  (jump_then (Label block_2))
                  (jump_else (Label block_3)))))))
         ((Label block_1)
          (Seq
            (Assign
              $ea.1
              (Allocate
                3
                (Vector (Integer Integer Integer))))
            (Seq
              (Assign
                _.3
                (VecSet (Var $ea.1) 0 (Int 1)))
              (Seq
                (Assign
                  _.2
                  (VecSet (Var $ea.1) 1 (Int 2)))
                (Seq
                  (Assign
                    _.1
                    (VecSet (Var $ea.1) 2 (Int 3)))
                  (Seq
                    (Assign vec.1 (Atm (Var $ea.1)))
                    (Seq
                      (Assign
                        $tmp.5
                        (FunRef (Label mapint) 2))
                      (Seq
                        (Assign $tmp.4 (FunRef (Label add1) 1))
                        (Seq
                          (Assign
                            vec2.1
                            (Call
                              (Var $tmp.5)
                              ((Var $tmp.4) (Var vec.1))))
                          (Seq
                            (Assign $tmp.6 (VecRef (Var vec2.1) 0))
                            (Seq
                              (Assign $tmp.7 (VecRef (Var vec2.1) 1))
                              (Seq
                                (Assign $tmp.8 (VecRef (Var vec2.1) 2))
                                (Seq
                                  (Assign
                                    $tmp.9
                                    (Prim Add ((Var $tmp.8) (Int 36))))
                                  (Seq
                                    (Assign
                                      $tmp.10
                                      (Prim Add ((Var $tmp.7) (Var $tmp.9))))
                                    (Return
                                      (Prim Add ((Var $tmp.6) (Var $tmp.10))))))))))))))))))
         ((Label block_2)
          (Seq
            (Assign _.4 (Atm Void))
            (Goto (Label block_1))))
         ((Label block_3)
          (Seq
            (Collect 32)
            (Goto (Label block_1))))))))
   (Def
     (Label mapint)
     ((args
        ((fun.1 (Function (Integer) Integer))
         (v.1 (Vector (Integer Integer Integer)))))
      (ret (Vector (Integer Integer Integer)))
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.11 (VecRef (Var v.1) 0))
            (Seq
              (Assign
                $ea.2
                (Call (Var fun.1) ((Var $tmp.11))))
              (Seq
                (Assign $tmp.12 (VecRef (Var v.1) 1))
                (Seq
                  (Assign
                    $ea.3
                    (Call (Var fun.1) ((Var $tmp.12))))
                  (Seq
                    (Assign $tmp.13 (VecRef (Var v.1) 2))
                    (Seq
                      (Assign
                        $ea.4
                        (Call (Var fun.1) ((Var $tmp.13))))
                      (Seq
                        (Assign $tmp.14 (GlobalVal free_ptr))
                        (Seq
                          (Assign
                            $tmp.15
                            (Prim Add ((Var $tmp.14) (Int 32))))
                          (Seq
                            (Assign
                              $tmp.16
                              (GlobalVal fromspace_end))
                            (IfStmt
                              (op Lt)
                              (arg1 (Var $tmp.15))
                              (arg2 (Var $tmp.16))
                              (jump_then (Label block_5))
                              (jump_else (Label block_6)))))))))))))
         ((Label block_4)
          (Seq
            (Assign
              $ea.5
              (Allocate
                3
                (Vector (Integer Integer Integer))))
            (Seq
              (Assign
                _.7
                (VecSet (Var $ea.5) 0 (Var $ea.2)))
              (Seq
                (Assign
                  _.6
                  (VecSet (Var $ea.5) 1 (Var $ea.3)))
                (Seq
                  (Assign
                    _.5
                    (VecSet (Var $ea.5) 2 (Var $ea.4)))
                  (Return (Atm (Var $ea.5))))))))
         ((Label block_5)
          (Seq
            (Assign _.8 (Atm Void))
            (Goto (Label block_4))))
         ((Label block_6)
          (Seq
            (Collect 32)
            (Goto (Label block_4))))))))
   (Def
     (Label add1)
     ((args ((x.1 Integer)))
      (ret Integer)
      (locals ())
      (body
        (((Label start) (Return (Atm (Int 2))))))))))
