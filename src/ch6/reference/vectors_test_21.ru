(CProgram
  (Info
    (locals_types
      (($ea.1 (Vector (Integer)))
       ($tmp.1 Integer)
       ($tmp.2 Integer)
       ($tmp.3 Integer)
       ($tmp.4 Integer)
       ($tmp.5 Integer)
       (_.1 Unit)
       (_.2 Unit)
       (v.1 (Vector (Integer)))
       (x.1 Integer))))
  (((Label block_1)
    (Seq
      (Assign
        $ea.1
        (Allocate 1 (Vector (Integer))))
      (Seq
        (Assign
          _.1
          (VecSet (Var $ea.1) 0 (Var x.1)))
        (Seq
          (Assign v.1 (Atm (Var $ea.1)))
          (Seq
            (Assign $tmp.5 (VecRef (Var v.1) 0))
            (Return
              (Prim Add ((Var $tmp.5) (Int 1)))))))))
   ((Label block_2)
    (Seq
      (Assign _.2 (Atm Void))
      (Goto (Label block_1))))
   ((Label block_3)
    (Seq
      (Collect 16)
      (Goto (Label block_1))))
   ((Label block_4)
    (Seq
      (Assign $tmp.2 (GlobalVal free_ptr))
      (Seq
        (Assign
          $tmp.3
          (Prim Add ((Var $tmp.2) (Int 16))))
        (Seq
          (Assign
            $tmp.4
            (GlobalVal fromspace_end))
          (IfStmt
            (op Lt)
            (arg1 (Var $tmp.3))
            (arg2 (Var $tmp.4))
            (jump_then (Label block_2))
            (jump_else (Label block_3)))))))
   ((Label block_5)
    (Seq
      (Assign x.1 (Atm (Int 41)))
      (Goto (Label block_4))))
   ((Label block_6)
    (Seq
      (Assign x.1 (Atm (Int 47)))
      (Goto (Label block_4))))
   ((Label start)
    (Seq
      (Assign $tmp.1 (Prim Read ()))
      (IfStmt
        (op Eq)
        (arg1 (Var $tmp.1))
        (arg2 (Int 1))
        (jump_then (Label block_5))
        (jump_else (Label block_6)))))))
