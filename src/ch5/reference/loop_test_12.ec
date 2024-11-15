(CProgram
  (Info (locals_types ()))
  (((Label start)
    (Seq
      (Assign x.1 (Atm (Int 1)))
      (Seq
        (Assign i.1 (Atm (Int 0)))
        (Goto (Label loop_1)))))
   ((Label block_1)
    (Seq
      (Assign x.1 (Atm (Int 42)))
      (Goto (Label loop_1))))
   ((Label block_2)
    (Return (Atm (Var x.1))))
   ((Label block_3)
    (IfStmt
      (op Eq)
      (arg1 (Var i.1))
      (arg2 (Int 0))
      (jump_then (Label block_1))
      (jump_else (Label block_2))))
   ((Label block_4)
    (IfStmt
      (op Eq)
      (arg1 (Var i.1))
      (arg2 (Int 1))
      (jump_then (Label block_1))
      (jump_else (Label block_2))))
   ((Label loop_1)
    (Seq
      (Assign $tmp.1 (Atm (Var x.1)))
      (IfStmt
        (op Eq)
        (arg1 (Var $tmp.1))
        (arg2 (Int 1))
        (jump_then (Label block_3))
        (jump_else (Label block_4)))))))
