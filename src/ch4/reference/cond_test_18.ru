(CProgram
  (Info
    (locals_types
      (($tmp.1 Integer) ($tmp.2 Integer))))
  (((Label block_1)
    (Return
      (Prim Add ((Int 2) (Var $tmp.2)))))
   ((Label block_2)
    (Seq
      (Assign $tmp.2 (Atm (Int 40)))
      (Goto (Label block_1))))
   ((Label block_3)
    (Seq
      (Assign $tmp.2 (Atm (Int 444)))
      (Goto (Label block_1))))
   ((Label block_4)
    (Return (Atm (Int 777))))
   ((Label block_5)
    (Seq
      (Assign
        $tmp.1
        (Prim Add ((Int 1) (Int 1))))
      (IfStmt
        (op Eq)
        (arg1 (Var $tmp.1))
        (arg2 (Int 2))
        (jump_then (Label block_2))
        (jump_else (Label block_3)))))
   ((Label start)
    (IfStmt
      (op Eq)
      (arg1 (Int 1))
      (arg2 (Int 0))
      (jump_then (Label block_4))
      (jump_else (Label block_5))))))
