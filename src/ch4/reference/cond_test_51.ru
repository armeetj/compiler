(CProgram
  (Info (locals_types (($tmp.1 Integer))))
  (((Label block_1)
    (Return (Prim Read ())))
   ((Label block_2)
    (Return (Atm (Int 42))))
   ((Label start)
    (Seq
      (Assign $tmp.1 (Prim Read ()))
      (IfStmt
        (op Eq)
        (arg1 (Int 0))
        (arg2 (Var $tmp.1))
        (jump_then (Label block_1))
        (jump_else (Label block_2)))))))
