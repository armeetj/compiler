(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($ea.1 (Function (Integer) Boolean))
         ($ea.2
           (Vector ((Function (Integer) Boolean))))
         ($tmp.1 Integer)
         ($tmp.2 Integer)
         ($tmp.3 Integer)
         ($tmp.4 (Function (Integer) Boolean))
         ($tmp.5 (Function (Integer) Boolean))
         (_.1 Unit)
         (_.2 Unit)
         (apply_1 Boolean)
         (dummy.1 Unit)
         (even? (Function (Integer) Boolean))
         (odd? (Function (Integer) Boolean))
         (vec.1
           (Vector ((Function (Integer) Boolean))))))
      (body
        (((Label block_1)
          (Return (Atm (Int 999))))
         ((Label block_2)
          (Return (Atm (Int 42))))
         ((Label block_3)
          (Seq
            (Assign
              $ea.2
              (Allocate
                1
                (Vector ((Function (Integer) Boolean)))))
            (Seq
              (Assign
                _.1
                (VecSet (Var $ea.2) 0 (Var $ea.1)))
              (Seq
                (Assign vec.1 (Atm (Var $ea.2)))
                (Seq
                  (Assign $tmp.4 (FunRef (Label even?) 1))
                  (Seq
                    (Assign
                      dummy.1
                      (VecSet (Var vec.1) 0 (Var $tmp.4)))
                    (Seq
                      (Assign $tmp.5 (VecRef (Var vec.1) 0))
                      (Seq
                        (Assign
                          apply_1
                          (Call (Var $tmp.5) ((Int 21))))
                        (IfStmt
                          (op Eq)
                          (arg1 (Var apply_1))
                          (arg2 (Bool true))
                          (jump_then (Label block_1))
                          (jump_else (Label block_2)))))))))))
         ((Label block_4)
          (Seq
            (Assign _.2 (Atm Void))
            (Goto (Label block_3))))
         ((Label block_5)
          (Seq
            (Collect 16)
            (Goto (Label block_3))))
         ((Label start)
          (Seq
            (Assign $ea.1 (FunRef (Label odd?) 1))
            (Seq
              (Assign $tmp.1 (GlobalVal free_ptr))
              (Seq
                (Assign
                  $tmp.2
                  (Prim Add ((Var $tmp.1) (Int 16))))
                (Seq
                  (Assign
                    $tmp.3
                    (GlobalVal fromspace_end))
                  (IfStmt
                    (op Lt)
                    (arg1 (Var $tmp.2))
                    (arg2 (Var $tmp.3))
                    (jump_then (Label block_4))
                    (jump_else (Label block_5))))))))))))
   (Def
     (Label even?)
     ((args ((x.1 Integer)))
      (ret Boolean)
      (locals
        (($tmp.6 Integer)
         ($tmp.7 Integer)
         ($tmp.8 (Function (Integer) Boolean))
         (odd? (Function (Integer) Boolean))
         (x.1 Integer)))
      (body
        (((Label block_6)
          (Return (Atm (Bool true))))
         ((Label block_7)
          (Seq
            (Assign $tmp.8 (FunRef (Label odd?) 1))
            (Seq
              (Assign $tmp.6 (Prim Negate ((Int 1))))
              (Seq
                (Assign
                  $tmp.7
                  (Prim Add ((Var $tmp.6) (Var x.1))))
                (TailCall (Var $tmp.8) ((Var $tmp.7)))))))
         ((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var x.1))
            (arg2 (Int 0))
            (jump_then (Label block_6))
            (jump_else (Label block_7))))))))
   (Def
     (Label odd?)
     ((args ((x.2 Integer)))
      (ret Boolean)
      (locals
        (($tmp.10 Integer)
         ($tmp.11 (Function (Integer) Boolean))
         ($tmp.9 Integer)
         (even? (Function (Integer) Boolean))
         (x.2 Integer)))
      (body
        (((Label block_8)
          (Return (Atm (Bool false))))
         ((Label block_9)
          (Seq
            (Assign
              $tmp.11
              (FunRef (Label even?) 1))
            (Seq
              (Assign $tmp.9 (Prim Negate ((Int 1))))
              (Seq
                (Assign
                  $tmp.10
                  (Prim Add ((Var $tmp.9) (Var x.2))))
                (TailCall (Var $tmp.11) ((Var $tmp.10)))))))
         ((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var x.2))
            (arg2 (Int 0))
            (jump_then (Label block_8))
            (jump_else (Label block_9))))))))))
