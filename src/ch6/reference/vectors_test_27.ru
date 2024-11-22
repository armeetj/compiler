(CProgram
  (Info
    (locals_types
      (($ea.1 (Vector (Boolean)))
       ($tmp.1 Integer)
       ($tmp.2 Integer)
       ($tmp.3 Integer)
       ($tmp.4 Integer)
       ($tmp.5 Integer)
       (_.1 Unit)
       (_.2 Unit)
       (v.1 (Vector (Boolean)))
       (vecref_1 Boolean))))
  (((Label block_1)
    (Return (Prim Negate ((Var $tmp.5)))))
   ((Label block_2)
    (Seq
      (Assign $tmp.4 (Prim Read ()))
      (Seq
        (Assign
          $tmp.5
          (Prim Negate ((Var $tmp.4))))
        (Goto (Label block_1)))))
   ((Label block_3)
    (Seq
      (Assign $tmp.5 (Prim Read ()))
      (Goto (Label block_1))))
   ((Label block_4)
    (Seq
      (Assign
        $ea.1
        (Allocate 1 (Vector (Boolean))))
      (Seq
        (Assign
          _.1
          (VecSet (Var $ea.1) 0 (Bool true)))
        (Seq
          (Assign v.1 (Atm (Var $ea.1)))
          (Seq
            (Assign vecref_1 (VecRef (Var v.1) 0))
            (IfStmt
              (op Eq)
              (arg1 (Var vecref_1))
              (arg2 (Bool true))
              (jump_then (Label block_2))
              (jump_else (Label block_3))))))))
   ((Label block_5)
    (Seq
      (Assign _.2 (Atm Void))
      (Goto (Label block_4))))
   ((Label block_6)
    (Seq
      (Collect 16)
      (Goto (Label block_4))))
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
            (jump_then (Label block_5))
            (jump_else (Label block_6)))))))))
