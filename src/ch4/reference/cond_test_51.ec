(CProgram
  (Info (locals_types ()))
  (((Label start)
    (Seq
      (Assign $tmp.1 (Prim Read ()))
      (IfStmt
        (op Eq)
        (arg1 (Int 0))
        (arg2 (Var $tmp.1))
        (jump_then (Label block_1))
        (jump_else (Label block_2)))))
   ((Label block_1)
    (Return (Prim Read ())))
   ((Label block_2)
    (Return (Atm (Int 42))))))
