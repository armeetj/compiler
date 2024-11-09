(CProgram
  (Info
    (locals_types
      (($tmp.1 Integer) (x.1 Integer))))
  (((Label block_1)
    (Return (Atm (Int 42))))
   ((Label block_2)
    (Return (Atm (Int 777))))
   ((Label block_3)
    (IfStmt
      (op Eq)
      (arg1 (Var $tmp.1))
      (arg2 (Int 42))
      (jump_then (Label block_1))
      (jump_else (Label block_2))))
   ((Label block_4)
    (Seq
      (Assign $tmp.1 (Atm (Var x.1)))
      (Goto (Label block_3))))
   ((Label block_5)
    (Seq
      (Assign $tmp.1 (Atm (Int 20)))
      (Goto (Label block_3))))
   ((Label start)
    (Seq
      (Assign x.1 (Atm (Int 42)))
      (IfStmt
        (op Eq)
        (arg1 (Var x.1))
        (arg2 (Int 42))
        (jump_then (Label block_4))
        (jump_else (Label block_5)))))))
