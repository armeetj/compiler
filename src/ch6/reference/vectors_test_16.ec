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
            (jump_then (Label block_14))
            (jump_else (Label block_15)))))))
   ((Label block_1)
    (Seq
      (Assign
        $ea.8
        (Allocate
          2
          (Vector
            ((Vector
               (Integer Integer (Vector (Boolean))))
             (Vector ((Vector (Integer))))))))
      (Seq
        (Assign
          _.12
          (VecSet (Var $ea.8) 0 (Var $ea.6)))
        (Seq
          (Assign
            _.11
            (VecSet (Var $ea.8) 1 (Var $ea.7)))
          (Seq
            (Assign f.1 (Atm (Var $ea.8)))
            (Seq
              (Assign $tmp.16 (VecRef (Var f.1) 0))
              (Return (VecRef (Var $tmp.16) 1))))))))
   ((Label block_10)
    (Seq
      (Assign
        $ea.2
        (Allocate 1 (Vector (Boolean))))
      (Seq
        (Assign
          _.3
          (VecSet (Var $ea.2) 0 (Bool true)))
        (Seq
          (Assign $ea.3 (Atm (Var $ea.2)))
          (Seq
            (Assign $tmp.7 (GlobalVal free_ptr))
            (Seq
              (Assign
                $tmp.8
                (Prim Add ((Var $tmp.7) (Int 32))))
              (Seq
                (Assign
                  $tmp.9
                  (GlobalVal fromspace_end))
                (IfStmt
                  (op Lt)
                  (arg1 (Var $tmp.8))
                  (arg2 (Var $tmp.9))
                  (jump_then (Label block_8))
                  (jump_else (Label block_9))))))))))
   ((Label block_11)
    (Seq
      (Assign _.4 (Atm Void))
      (Goto (Label block_10))))
   ((Label block_12)
    (Seq
      (Collect 16)
      (Goto (Label block_10))))
   ((Label block_13)
    (Seq
      (Assign
        $ea.1
        (Allocate 1 (Vector (Integer))))
      (Seq
        (Assign
          _.1
          (VecSet (Var $ea.1) 0 (Int 0)))
        (Seq
          (Assign dummy.1 (Atm (Var $ea.1)))
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
                  (jump_then (Label block_11))
                  (jump_else (Label block_12))))))))))
   ((Label block_14)
    (Seq
      (Assign _.2 (Atm Void))
      (Goto (Label block_13))))
   ((Label block_15)
    (Seq
      (Collect 16)
      (Goto (Label block_13))))
   ((Label block_2)
    (Seq
      (Assign _.13 (Atm Void))
      (Goto (Label block_1))))
   ((Label block_3)
    (Seq
      (Collect 24)
      (Goto (Label block_1))))
   ((Label block_4)
    (Seq
      (Assign
        $ea.5
        (Allocate
          1
          (Vector ((Vector (Integer))))))
      (Seq
        (Assign
          _.9
          (VecSet (Var $ea.5) 0 (Var dummy.1)))
        (Seq
          (Assign $ea.7 (Atm (Var $ea.5)))
          (Seq
            (Assign $tmp.13 (GlobalVal free_ptr))
            (Seq
              (Assign
                $tmp.14
                (Prim Add ((Var $tmp.13) (Int 24))))
              (Seq
                (Assign
                  $tmp.15
                  (GlobalVal fromspace_end))
                (IfStmt
                  (op Lt)
                  (arg1 (Var $tmp.14))
                  (arg2 (Var $tmp.15))
                  (jump_then (Label block_2))
                  (jump_else (Label block_3))))))))))
   ((Label block_5)
    (Seq
      (Assign _.10 (Atm Void))
      (Goto (Label block_4))))
   ((Label block_6)
    (Seq
      (Collect 16)
      (Goto (Label block_4))))
   ((Label block_7)
    (Seq
      (Assign
        $ea.4
        (Allocate
          3
          (Vector
            (Integer Integer (Vector (Boolean))))))
      (Seq
        (Assign
          _.7
          (VecSet (Var $ea.4) 0 (Int 1)))
        (Seq
          (Assign
            _.6
            (VecSet (Var $ea.4) 1 (Int 42)))
          (Seq
            (Assign
              _.5
              (VecSet (Var $ea.4) 2 (Var $ea.3)))
            (Seq
              (Assign $ea.6 (Atm (Var $ea.4)))
              (Seq
                (Assign $tmp.10 (GlobalVal free_ptr))
                (Seq
                  (Assign
                    $tmp.11
                    (Prim Add ((Var $tmp.10) (Int 16))))
                  (Seq
                    (Assign
                      $tmp.12
                      (GlobalVal fromspace_end))
                    (IfStmt
                      (op Lt)
                      (arg1 (Var $tmp.11))
                      (arg2 (Var $tmp.12))
                      (jump_then (Label block_5))
                      (jump_else (Label block_6))))))))))))
   ((Label block_8)
    (Seq
      (Assign _.8 (Atm Void))
      (Goto (Label block_7))))
   ((Label block_9)
    (Seq
      (Collect 32)
      (Goto (Label block_7))))))
