(CProgram
  (Info (locals_types ()))
  (((Label start)
    (Seq
      (Assign x.1 (Atm (Int 1)))
      (Seq
        (Assign x.1 (Atm (Int 2)))
        (Seq
          (Assign $tmp.1 (Atm (Var x.1)))
          (IfStmt
            (op Eq)
            (arg1 (Var $tmp.1))
            (arg2 (Int 2))
            (jump_then (Label block_1))
            (jump_else (Label block_2)))))))
   ((Label block_1)
    (Return (Atm (Int 42))))
   ((Label block_2) (Return (Atm (Int 0))))))
