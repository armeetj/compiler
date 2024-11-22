(CProgram
  (Info
    (locals_types
      (($ea.1 (Vector (Integer)))
       ($ea.2 (Vector (Integer)))
       ($tmp.1 Integer)
       ($tmp.2 Integer)
       ($tmp.3 Integer)
       ($tmp.4 Integer)
       ($tmp.5 Integer)
       ($tmp.6 Integer)
       ($tmp.7 Integer)
       ($tmp.8 Integer)
       (_.1 Unit)
       (_.2 Unit)
       (_.3 Unit)
       (_.4 Unit)
       (v.1 (Vector (Integer)))
       (x.1 (Vector (Integer))))))
  (((Label block_1)
    (Seq
      (Assign
        $ea.2
        (Allocate 1 (Vector (Integer))))
      (Seq
        (Assign
          _.3
          (VecSet (Var $ea.2) 0 (Int 2)))
        (Seq
          (Assign x.1 (Atm (Var $ea.2)))
          (Seq
            (Assign $tmp.7 (VecRef (Var x.1) 0))
            (Seq
              (Assign $tmp.8 (VecRef (Var v.1) 0))
              (Return
                (Prim Add ((Var $tmp.7) (Var $tmp.8))))))))))
   ((Label block_2)
    (Seq
      (Assign _.4 (Atm Void))
      (Goto (Label block_1))))
   ((Label block_3)
    (Seq
      (Collect 16)
      (Goto (Label block_1))))
   ((Label block_4)
    (Seq
      (Assign
        $ea.1
        (Allocate 1 (Vector (Integer))))
      (Seq
        (Assign
          _.1
          (VecSet (Var $ea.1) 0 (Int 40)))
        (Seq
          (Assign v.1 (Atm (Var $ea.1)))
          (Seq
            (Assign $tmp.4 (GlobalVal free_ptr))
            (Seq
              (Assign
                $tmp.5
                (Prim Add ((Var $tmp.4) (Int 16))))
              (Seq
                (Assign
                  $tmp.6
                  (GlobalVal fromspace_end))
                (IfStmt
                  (op Lt)
                  (arg1 (Var $tmp.5))
                  (arg2 (Var $tmp.6))
                  (jump_then (Label block_2))
                  (jump_else (Label block_3))))))))))
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
