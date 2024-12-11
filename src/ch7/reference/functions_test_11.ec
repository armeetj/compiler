(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.4 (FunRef (Label f) 2))
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
                    (jump_then (Label block_2))
                    (jump_else (Label block_3))))))))
         ((Label block_1)
          (Seq
            (Assign
              $ea.1
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.1
                (VecSet (Var $ea.1) 0 (Int 42)))
              (TailCall
                (Var $tmp.4)
                ((Int 0) (Var $ea.1))))))
         ((Label block_2)
          (Seq
            (Assign _.2 (Atm Void))
            (Goto (Label block_1))))
         ((Label block_3)
          (Seq
            (Collect 16)
            (Goto (Label block_1))))))))
   (Def
     (Label f)
     ((args
        ((n.1 Integer) (v.1 (Vector (Integer)))))
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var n.1))
            (arg2 (Int 100))
            (jump_then (Label block_7))
            (jump_else (Label block_8))))
         ((Label block_4)
          (Seq
            (Assign
              $ea.3
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.3
                (VecSet (Var $ea.3) 0 (Var $ea.2)))
              (TailCall
                (Var $tmp.9)
                ((Var $tmp.5) (Var $ea.3))))))
         ((Label block_5)
          (Seq
            (Assign _.4 (Atm Void))
            (Goto (Label block_4))))
         ((Label block_6)
          (Seq
            (Collect 16)
            (Goto (Label block_4))))
         ((Label block_7)
          (Return (VecRef (Var v.1) 0)))
         ((Label block_8)
          (Seq
            (Assign $tmp.9 (FunRef (Label f) 2))
            (Seq
              (Assign
                $tmp.5
                (Prim Add ((Var n.1) (Int 1))))
              (Seq
                (Assign $ea.2 (VecRef (Var v.1) 0))
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
                        (jump_then (Label block_5))
                        (jump_else (Label block_6))))))))))))))))
