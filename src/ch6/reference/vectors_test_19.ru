(CProgram
  (Info (locals_types ((x.1 Unit))))
  (((Label block_1)
    (Return (Atm (Int 42))))
   ((Label block_2) (Return (Atm (Int 0))))
   ((Label start)
    (Seq
      (Assign x.1 (Atm Void))
      (IfStmt
        (op Eq)
        (arg1 (Var x.1))
        (arg2 (Var x.1))
        (jump_then (Label block_1))
        (jump_else (Label block_2)))))))
