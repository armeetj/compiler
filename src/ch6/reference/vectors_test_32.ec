(CProgram
  (Info (locals_types ()))
  (((Label start)
    (Seq
      (Assign $tmp.1 (GlobalVal free_ptr))
      (Seq
        (Assign
          $tmp.2
          (Prim Add ((Var $tmp.1) (Int 24))))
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
        (Allocate 2 (Vector (Integer Integer))))
      (Seq
        (Assign
          _.2
          (VecSet (Var $ea.1) 0 (Int 60)))
        (Seq
          (Assign
            _.1
            (VecSet (Var $ea.1) 1 (Int 18)))
          (Seq
            (Assign v.1 (Atm (Var $ea.1)))
            (Seq
              (Assign $tmp.4 (VecRef (Var v.1) 0))
              (Seq
                (Assign $tmp.5 (VecRef (Var v.1) 1))
                (Return
                  (Prim Sub ((Var $tmp.4) (Var $tmp.5)))))))))))
   ((Label block_2)
    (Seq
      (Assign _.3 (Atm Void))
      (Goto (Label block_1))))
   ((Label block_3)
    (Seq
      (Collect 24)
      (Goto (Label block_1))))))
