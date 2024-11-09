(CProgram
  (Info (locals_types ()))
  (((Label block_1) (Return (Atm (Int 0))))
   ((Label block_2)
    (Return (Atm (Int 42))))
   ((Label start)
    (IfStmt
      (op Lt)
      (arg1 (Int 2))
      (arg2 (Int 2))
      (jump_then (Label block_1))
      (jump_else (Label block_2))))))
