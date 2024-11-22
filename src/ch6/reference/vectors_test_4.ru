(CProgram
  (Info
    (locals_types
      (($ea.1 (Vector (Integer)))
       ($tmp.1 Integer)
       ($tmp.2 Integer)
       ($tmp.3 Integer)
       (_.1 Unit)
       (_.2 Unit)
       (v.1 (Vector (Integer))))))
  (((Label block_1)
    (Return (Atm (Int 42))))
   ((Label block_2)
    (Return (Atm (Int 777))))
   ((Label block_3)
    (Seq
      (Assign
        $ea.1
        (Allocate 1 (Vector (Integer))))
      (Seq
        (Assign
          _.1
          (VecSet (Var $ea.1) 0 (Int 0)))
        (Seq
          (Assign v.1 (Atm (Var $ea.1)))
          (IfStmt
            (op Eq)
            (arg1 (Var v.1))
            (arg2 (Var v.1))
            (jump_then (Label block_1))
            (jump_else (Label block_2)))))))
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
            (jump_else (Label block_5)))))))))
