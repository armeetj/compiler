(CProgram
  (Info
    (locals_types
      (($ea.1 (Vector ()))
       ($tmp.1 Integer)
       ($tmp.2 Integer)
       ($tmp.3 Integer)
       (_.1 Unit)
       (v0.1 (Vector ())))))
  (((Label block_1)
    (Seq
      (Assign $ea.1 (Allocate 0 (Vector ())))
      (Seq
        (Assign v0.1 (Atm (Var $ea.1)))
        (Return (Atm (Int 42))))))
   ((Label block_2)
    (Seq
      (Assign _.1 (Atm Void))
      (Goto (Label block_1))))
   ((Label block_3)
    (Seq (Collect 8) (Goto (Label block_1))))
   ((Label start)
    (Seq
      (Assign $tmp.1 (GlobalVal free_ptr))
      (Seq
        (Assign
          $tmp.2
          (Prim Add ((Var $tmp.1) (Int 8))))
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
