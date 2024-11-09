(CProgram
  (Info (locals_types ((x.1 Integer))))
  (((Label block_1)
    (Return (Atm (Int 42))))
   ((Label block_2)
    (Return (Atm (Int 77))))
   ((Label start)
    (Seq
      (Assign x.1 (Prim Read ()))
      (IfStmt
        (op Eq)
        (arg1 (Var x.1))
        (arg2 (Int 0))
        (jump_then (Label block_1))
        (jump_else (Label block_2)))))))
