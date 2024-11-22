(CProgram
  (Info (locals_types ()))
  (((Label start)
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
            (jump_then (Label block_7))
            (jump_else (Label block_8)))))))
   ((Label block_1)
    (Seq
      (Assign $tmp.7 (VecRef (Var t.1) 0))
      (Seq
        (Assign $tmp.8 (VecRef (Var t.1) 2))
        (Seq
          (Assign $tmp.9 (VecRef (Var $tmp.8) 0))
          (Return
            (Prim Add ((Var $tmp.7) (Var $tmp.9))))))))
   ((Label block_2)
    (Return (Atm (Int 44))))
   ((Label block_3)
    (Seq
      (Assign
        $ea.3
        (Allocate
          3
          (Vector
            (Integer Boolean (Vector (Integer))))))
      (Seq
        (Assign
          _.5
          (VecSet (Var $ea.3) 0 (Int 40)))
        (Seq
          (Assign
            _.4
            (VecSet (Var $ea.3) 1 (Bool true)))
          (Seq
            (Assign
              _.3
              (VecSet (Var $ea.3) 2 (Var $ea.2)))
            (Seq
              (Assign t.1 (Atm (Var $ea.3)))
              (Seq
                (Assign vecref_1 (VecRef (Var t.1) 1))
                (IfStmt
                  (op Eq)
                  (arg1 (Var vecref_1))
                  (arg2 (Bool true))
                  (jump_then (Label block_1))
                  (jump_else (Label block_2))))))))))
   ((Label block_4)
    (Seq
      (Assign _.6 (Atm Void))
      (Goto (Label block_3))))
   ((Label block_5)
    (Seq
      (Collect 32)
      (Goto (Label block_3))))
   ((Label block_6)
    (Seq
      (Assign
        $ea.1
        (Allocate 1 (Vector (Integer))))
      (Seq
        (Assign
          _.1
          (VecSet (Var $ea.1) 0 (Int 2)))
        (Seq
          (Assign $ea.2 (Atm (Var $ea.1)))
          (Seq
            (Assign $tmp.4 (GlobalVal free_ptr))
            (Seq
              (Assign
                $tmp.5
                (Prim Add ((Var $tmp.4) (Int 32))))
              (Seq
                (Assign
                  $tmp.6
                  (GlobalVal fromspace_end))
                (IfStmt
                  (op Lt)
                  (arg1 (Var $tmp.5))
                  (arg2 (Var $tmp.6))
                  (jump_then (Label block_4))
                  (jump_else (Label block_5))))))))))
   ((Label block_7)
    (Seq
      (Assign _.2 (Atm Void))
      (Goto (Label block_6))))
   ((Label block_8)
    (Seq
      (Collect 16)
      (Goto (Label block_6))))))
