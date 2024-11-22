(CProgram
  (Info
    (locals_types
      (($ea.1 (Vector (Integer Integer)))
       ($tmp.1 Integer)
       ($tmp.2 Integer)
       ($tmp.3 Integer)
       (_.1 Unit)
       (_.2 Unit)
       (_.3 Unit)
       (v.1 (Vector (Integer Integer))))))
  (((Label block_1)
    (Seq
      (Assign
        $ea.1
        (Allocate 2 (Vector (Integer Integer))))
      (Seq
        (Assign
          _.2
          (VecSet (Var $ea.1) 0 (Int 1)))
        (Seq
          (Assign
            _.1
            (VecSet (Var $ea.1) 1 (Int 2)))
          (Seq
            (Assign v.1 (Atm (Var $ea.1)))
            (Return (Atm (Int 42))))))))
   ((Label block_2)
    (Seq
      (Assign _.3 (Atm Void))
      (Goto (Label block_1))))
   ((Label block_3)
    (Seq
      (Collect 24)
      (Goto (Label block_1))))
   ((Label start)
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
            (jump_else (Label block_3)))))))))
