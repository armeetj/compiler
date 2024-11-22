(CProgram
  (Info
    (locals_types
      (($ea.1 (Vector (Integer)))
       ($ea.2
         (Vector
           ((Vector (Integer)) (Vector (Integer)))))
       ($tmp.1 Integer)
       ($tmp.2 Integer)
       ($tmp.3 Integer)
       ($tmp.4 Integer)
       ($tmp.5 Integer)
       ($tmp.6 Integer)
       ($tmp.7 (Vector (Integer)))
       (_.1 Unit)
       (_.2 Unit)
       (_.3 Unit)
       (_.4 Unit)
       (_.5 Unit)
       (a.1 (Vector (Integer)))
       (b.1
         (Vector
           ((Vector (Integer)) (Vector (Integer))))))))
  (((Label block_1)
    (Seq
      (Assign
        $ea.2
        (Allocate
          2
          (Vector
            ((Vector (Integer)) (Vector (Integer))))))
      (Seq
        (Assign
          _.4
          (VecSet (Var $ea.2) 0 (Var a.1)))
        (Seq
          (Assign
            _.3
            (VecSet (Var $ea.2) 1 (Var a.1)))
          (Seq
            (Assign b.1 (Atm (Var $ea.2)))
            (Seq
              (Assign $tmp.7 (VecRef (Var b.1) 0))
              (Seq
                (Assign
                  _.1
                  (VecSet (Var $tmp.7) 0 (Int 42)))
                (Return (VecRef (Var a.1) 0)))))))))
   ((Label block_2)
    (Seq
      (Assign _.5 (Atm Void))
      (Goto (Label block_1))))
   ((Label block_3)
    (Seq
      (Collect 24)
      (Goto (Label block_1))))
   ((Label block_4)
    (Seq
      (Assign
        $ea.1
        (Allocate 1 (Vector (Integer))))
      (Seq
        (Assign
          _.1
          (VecSet (Var $ea.1) 0 (Int 777)))
        (Seq
          (Assign a.1 (Atm (Var $ea.1)))
          (Seq
            (Assign $tmp.4 (GlobalVal free_ptr))
            (Seq
              (Assign
                $tmp.5
                (Prim Add ((Var $tmp.4) (Int 24))))
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
