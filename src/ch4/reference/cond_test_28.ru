(CProgram
  (Info (locals_types (($tmp.1 Boolean))))
  (((Label block_1)
    (Return (Atm (Int 42))))
   ((Label block_2) (Return (Atm (Int 0))))
   ((Label start)
    (Seq
      (Assign
        $tmp.1
        (Prim Eq ((Int 20) (Int 0))))
      (IfStmt
        (op Eq)
        (arg1 (Var $tmp.1))
        (arg2 (Bool false))
        (jump_then (Label block_1))
        (jump_else (Label block_2)))))))
