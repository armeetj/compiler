(CProgram
  (Info (locals_types ()))
  (((Label start)
    (IfStmt
      (op Eq)
      (arg1 (Bool true))
      (arg2 (Bool true))
      (jump_then (Label block_1))
      (jump_else (Label block_2))))
   ((Label block_1)
    (Return (Atm (Int 42))))
   ((Label block_2) (Return (Atm (Int 0))))))
