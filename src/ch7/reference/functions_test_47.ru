(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($tmp.1 (Function (Integer) Integer))
         ($tmp.2 Integer)
         (sum (Function (Integer) Integer))))
      (body
        (((Label block_1)
          (Return (Atm (Int 42))))
         ((Label block_2)
          (Return (Atm (Int 777))))
         ((Label start)
          (Seq
            (Assign $tmp.1 (FunRef (Label sum) 1))
            (Seq
              (Assign
                $tmp.2
                (Call (Var $tmp.1) ((Int 3))))
              (IfStmt
                (op Eq)
                (arg1 (Var $tmp.2))
                (arg2 (Int 6))
                (jump_then (Label block_1))
                (jump_else (Label block_2))))))))))
   (Def
     (Label sum)
     ((args ((x.1 Integer)))
      (ret Integer)
      (locals
        (($ea.1 (Vector (Integer)))
         ($ea.2 (Vector (Integer)))
         ($ea.3 Integer)
         ($ea.4 (Vector (Integer)))
         ($tmp.10 Integer)
         ($tmp.11 Integer)
         ($tmp.12 Integer)
         ($tmp.13 Integer)
         ($tmp.14 Integer)
         ($tmp.15 (Function (Integer) Integer))
         ($tmp.16 Integer)
         ($tmp.3 Integer)
         ($tmp.4 Integer)
         ($tmp.5 Integer)
         ($tmp.6 Integer)
         ($tmp.7 Integer)
         ($tmp.8 Integer)
         ($tmp.9 Integer)
         (_.1 Unit)
         (_.2 Unit)
         (_.3 Unit)
         (_.4 Unit)
         (_.5 Unit)
         (_.6 Unit)
         (neg-one.1 (Vector (Integer)))
         (one.1 (Vector (Integer)))
         (sum (Function (Integer) Integer))
         (x-vec.1 (Vector (Integer)))
         (x.1 Integer)))
      (body
        (((Label block_10)
          (Seq
            (Collect 16)
            (Goto (Label block_8))))
         ((Label block_11)
          (Seq
            (Assign
              $ea.1
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.1
                (VecSet (Var $ea.1) 0 (Var x.1)))
              (Seq
                (Assign x-vec.1 (Atm (Var $ea.1)))
                (Seq
                  (Assign $tmp.6 (GlobalVal free_ptr))
                  (Seq
                    (Assign
                      $tmp.7
                      (Prim Add ((Var $tmp.6) (Int 16))))
                    (Seq
                      (Assign
                        $tmp.8
                        (GlobalVal fromspace_end))
                      (IfStmt
                        (op Lt)
                        (arg1 (Var $tmp.7))
                        (arg2 (Var $tmp.8))
                        (jump_then (Label block_9))
                        (jump_else (Label block_10))))))))))
         ((Label block_12)
          (Seq
            (Assign _.2 (Atm Void))
            (Goto (Label block_11))))
         ((Label block_13)
          (Seq
            (Collect 16)
            (Goto (Label block_11))))
         ((Label block_3)
          (Return (VecRef (Var one.1) 0)))
         ((Label block_4)
          (Seq
            (Assign $tmp.15 (FunRef (Label sum) 1))
            (Seq
              (Assign
                $tmp.13
                (VecRef (Var neg-one.1) 0))
              (Seq
                (Assign
                  $tmp.14
                  (Prim Add ((Var x.1) (Var $tmp.13))))
                (Seq
                  (Assign
                    $tmp.16
                    (Call (Var $tmp.15) ((Var $tmp.14))))
                  (Return
                    (Prim Add ((Var x.1) (Var $tmp.16)))))))))
         ((Label block_5)
          (Seq
            (Assign
              $ea.4
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.5
                (VecSet (Var $ea.4) 0 (Var $ea.3)))
              (Seq
                (Assign neg-one.1 (Atm (Var $ea.4)))
                (Seq
                  (Assign
                    $tmp.12
                    (VecRef (Var x-vec.1) 0))
                  (IfStmt
                    (op Eq)
                    (arg1 (Var $tmp.12))
                    (arg2 (Int 1))
                    (jump_then (Label block_3))
                    (jump_else (Label block_4))))))))
         ((Label block_6)
          (Seq
            (Assign _.6 (Atm Void))
            (Goto (Label block_5))))
         ((Label block_7)
          (Seq
            (Collect 16)
            (Goto (Label block_5))))
         ((Label block_8)
          (Seq
            (Assign
              $ea.2
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.3
                (VecSet (Var $ea.2) 0 (Int 1)))
              (Seq
                (Assign one.1 (Atm (Var $ea.2)))
                (Seq
                  (Assign $ea.3 (Prim Negate ((Int 1))))
                  (Seq
                    (Assign $tmp.9 (GlobalVal free_ptr))
                    (Seq
                      (Assign
                        $tmp.10
                        (Prim Add ((Var $tmp.9) (Int 16))))
                      (Seq
                        (Assign
                          $tmp.11
                          (GlobalVal fromspace_end))
                        (IfStmt
                          (op Lt)
                          (arg1 (Var $tmp.10))
                          (arg2 (Var $tmp.11))
                          (jump_then (Label block_6))
                          (jump_else (Label block_7)))))))))))
         ((Label block_9)
          (Seq
            (Assign _.4 (Atm Void))
            (Goto (Label block_8))))
         ((Label start)
          (Seq
            (Assign $tmp.3 (GlobalVal free_ptr))
            (Seq
              (Assign
                $tmp.4
                (Prim Add ((Var $tmp.3) (Int 16))))
              (Seq
                (Assign
                  $tmp.5
                  (GlobalVal fromspace_end))
                (IfStmt
                  (op Lt)
                  (arg1 (Var $tmp.4))
                  (arg2 (Var $tmp.5))
                  (jump_then (Label block_12))
                  (jump_else (Label block_13)))))))))))))