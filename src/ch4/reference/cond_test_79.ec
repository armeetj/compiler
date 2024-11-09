(CProgram
  (Info (locals_types ()))
  (((Label start)
    (Seq
      (Assign $tmp.1 (Prim Read ()))
      (IfStmt
        (op Eq)
        (arg1 (Var $tmp.1))
        (arg2 (Int 1))
        (jump_then (Label block_1))
        (jump_else (Label block_3)))))
   ((Label block_3)
    (Seq
      (Assign $tmp.2 (Prim Read ()))
      (IfStmt
        (op Eq)
        (arg1 (Var $tmp.2))
        (arg2 (Int 0))
        (jump_then (Label block_1))
        (jump_else (Label block_2)))))
   ((Label block_1)
    (Return (Atm (Int 42))))
   ((Label block_2) (Return (Atm (Int 0))))))
