(CProgram
  (Info (locals_types ()))
  (((Label start)
    (Seq
      (Assign
        $tmp.1
        (Prim Gt ((Int 1) (Int 0))))
      (IfStmt
        (op Eq)
        (arg1 (Bool true))
        (arg2 (Var $tmp.1))
        (jump_then (Label block_1))
        (jump_else (Label block_2)))))
   ((Label block_1)
    (Return (Atm (Int 42))))
   ((Label block_2)
    (Return (Atm (Int 777))))))
