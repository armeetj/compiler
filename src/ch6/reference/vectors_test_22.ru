(CProgram
  (Info
    (locals_types
      (($ea.1 (Vector (Integer)))
       ($ea.2 (Vector (Integer)))
       ($ea.3 (Vector ((Vector (Integer)))))
       ($ea.4 (Vector (Integer)))
       ($tmp.1 Integer)
       ($tmp.10 (Vector (Integer)))
       ($tmp.11 Integer)
       ($tmp.2 Integer)
       ($tmp.3 Integer)
       ($tmp.4 Integer)
       ($tmp.5 Integer)
       ($tmp.6 Integer)
       ($tmp.7 Integer)
       ($tmp.8 Integer)
       ($tmp.9 Integer)
       (_.1 Unit)
       (_.2 Unit)
       (_.3 Unit)
       (_.4 Unit)
       (_.5 Unit)
       (_.6 Unit)
       (v.1 (Vector ((Vector (Integer)))))
       (w.1 (Vector (Integer)))
       (x.1 Integer))))
  (((Label block_1)
    (Seq
      (Assign
        $ea.4
        (Allocate 1 (Vector (Integer))))
      (Seq
        (Assign
          _.5
          (VecSet (Var $ea.4) 0 (Int 42)))
        (Seq
          (Assign w.1 (Atm (Var $ea.4)))
          (Seq
            (Assign
              _.1
              (VecSet (Var v.1) 0 (Var w.1)))
            (Seq
              (Assign x.1 (Atm (Int 0)))
              (Seq
                (Assign $tmp.10 (VecRef (Var v.1) 0))
                (Seq
                  (Assign
                    $tmp.11
                    (VecRef (Var $tmp.10) 0))
                  (Return
                    (Prim Add ((Var x.1) (Var $tmp.11))))))))))))
   ((Label block_2)
    (Seq
      (Assign _.6 (Atm Void))
      (Goto (Label block_1))))
   ((Label block_3)
    (Seq
      (Collect 16)
      (Goto (Label block_1))))
   ((Label block_4)
    (Seq
      (Assign
        $ea.3
        (Allocate
          1
          (Vector ((Vector (Integer))))))
      (Seq
        (Assign
          _.3
          (VecSet (Var $ea.3) 0 (Var $ea.2)))
        (Seq
          (Assign v.1 (Atm (Var $ea.3)))
          (Seq
            (Assign $tmp.7 (GlobalVal free_ptr))
            (Seq
              (Assign
                $tmp.8
                (Prim Add ((Var $tmp.7) (Int 16))))
              (Seq
                (Assign
                  $tmp.9
                  (GlobalVal fromspace_end))
                (IfStmt
                  (op Lt)
                  (arg1 (Var $tmp.8))
                  (arg2 (Var $tmp.9))
                  (jump_then (Label block_2))
                  (jump_else (Label block_3))))))))))
   ((Label block_5)
    (Seq
      (Assign _.4 (Atm Void))
      (Goto (Label block_4))))
   ((Label block_6)
    (Seq
      (Collect 16)
      (Goto (Label block_4))))
   ((Label block_7)
    (Seq
      (Assign
        $ea.1
        (Allocate 1 (Vector (Integer))))
      (Seq
        (Assign
          _.1
          (VecSet (Var $ea.1) 0 (Int 44)))
        (Seq
          (Assign $ea.2 (Atm (Var $ea.1)))
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
                  (jump_then (Label block_5))
                  (jump_else (Label block_6))))))))))
   ((Label block_8)
    (Seq
      (Assign _.2 (Atm Void))
      (Goto (Label block_7))))
   ((Label block_9)
    (Seq
      (Collect 16)
      (Goto (Label block_7))))
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
            (jump_then (Label block_8))
            (jump_else (Label block_9)))))))))
