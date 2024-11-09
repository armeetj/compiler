(CProgram
  (Info (locals_types ()))
  (((Label start)
    (IfStmt
      (op Ge)
      (arg1 (Int 2))
      (arg2 (Int 1))
      (jump_then (Label block_1))
      (jump_else (Label block_2))))
   ((Label block_1)
    (Return (Atm (Int 42))))
   ((Label block_2) (Return (Atm (Int 0))))))
