(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.1 (FunRef (Label zero) 1))
            (Seq
              (Assign
                $ea.1
                (Call (Var $tmp.1) ((Int 1))))
              (Seq
                (Assign $tmp.2 (FunRef (Label zero) 1))
                (Seq
                  (Assign
                    $ea.2
                    (Call (Var $tmp.2) ((Int 2))))
                  (Seq
                    (Assign $tmp.3 (GlobalVal free_ptr))
                    (Seq
                      (Assign
                        $tmp.4
                        (Prim Add ((Var $tmp.3) (Int 32))))
                      (Seq
                        (Assign
                          $tmp.5
                          (GlobalVal fromspace_end))
                        (IfStmt
                          (op Lt)
                          (arg1 (Var $tmp.4))
                          (arg2 (Var $tmp.5))
                          (jump_then (Label block_2))
                          (jump_else (Label block_3)))))))))))
         ((Label block_1)
          (Seq
            (Assign
              $ea.3
              (Allocate
                3
                (Vector
                  ((Vector ()) (Vector ()) Integer))))
            (Seq
              (Assign
                _.3
                (VecSet (Var $ea.3) 0 (Var $ea.1)))
              (Seq
                (Assign
                  _.2
                  (VecSet (Var $ea.3) 1 (Var $ea.2)))
                (Seq
                  (Assign
                    _.1
                    (VecSet (Var $ea.3) 2 (Int 42)))
                  (Return (VecRef (Var $ea.3) 2)))))))
         ((Label block_2)
          (Seq
            (Assign _.4 (Atm Void))
            (Goto (Label block_1))))
         ((Label block_3)
          (Seq
            (Collect 32)
            (Goto (Label block_1))))))))
   (Def
     (Label minus)
     ((args ((n.1 Integer) (m.1 Integer)))
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign
              $tmp.6
              (Prim Negate ((Var m.1))))
            (Return
              (Prim Add ((Var n.1) (Var $tmp.6))))))))))
   (Def
     (Label zero)
     ((args ((x.1 Integer)))
      (ret (Vector ()))
      (locals ())
      (body
        (((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var x.1))
            (arg2 (Int 0))
            (jump_then (Label block_10))
            (jump_else (Label block_11))))
         ((Label block_10)
          (Seq
            (Assign $tmp.7 (GlobalVal free_ptr))
            (Seq
              (Assign
                $tmp.8
                (Prim Add ((Var $tmp.7) (Int 8))))
              (Seq
                (Assign
                  $tmp.9
                  (GlobalVal fromspace_end))
                (IfStmt
                  (op Lt)
                  (arg1 (Var $tmp.8))
                  (arg2 (Var $tmp.9))
                  (jump_then (Label block_5))
                  (jump_else (Label block_6)))))))
         ((Label block_11)
          (Seq
            (Assign $tmp.16 (FunRef (Label zero) 1))
            (Seq
              (Assign $tmp.10 (GlobalVal free_ptr))
              (Seq
                (Assign
                  $tmp.11
                  (Prim Add ((Var $tmp.10) (Int 16))))
                (Seq
                  (Assign
                    $tmp.12
                    (GlobalVal fromspace_end))
                  (IfStmt
                    (op Lt)
                    (arg1 (Var $tmp.11))
                    (arg2 (Var $tmp.12))
                    (jump_then (Label block_8))
                    (jump_else (Label block_9))))))))
         ((Label block_4)
          (Seq
            (Assign $ea.4 (Allocate 0 (Vector ())))
            (Return (Atm (Var $ea.4)))))
         ((Label block_5)
          (Seq
            (Assign _.5 (Atm Void))
            (Goto (Label block_4))))
         ((Label block_6)
          (Seq (Collect 8) (Goto (Label block_4))))
         ((Label block_7)
          (Seq
            (Assign
              $ea.5
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.6
                (VecSet (Var $ea.5) 0 (Var x.1)))
              (Seq
                (Assign $tmp.13 (VecRef (Var $ea.5) 0))
                (Seq
                  (Assign $tmp.14 (Prim Negate ((Int 1))))
                  (Seq
                    (Assign
                      $tmp.15
                      (Prim Add ((Var $tmp.13) (Var $tmp.14))))
                    (TailCall (Var $tmp.16) ((Var $tmp.15)))))))))
         ((Label block_8)
          (Seq
            (Assign _.7 (Atm Void))
            (Goto (Label block_7))))
         ((Label block_9)
          (Seq
            (Collect 16)
            (Goto (Label block_7))))))))))
