(CProgram
  (Info
    (locals_types
      (($tmp.1 Integer) ($tmp.2 Integer))))
  (((Label block_1)
    (Return (Prim Add ((Int 10) (Int 32)))))
   ((Label block_2)
    (Return (Prim Add ((Int 70) (Int 7)))))
   ((Label block_3)
    (Seq
      (Assign $tmp.2 (Prim Read ()))
      (IfStmt
        (op Eq)
        (arg1 (Var $tmp.2))
        (arg2 (Int 0))
        (jump_then (Label block_1))
        (jump_else (Label block_2)))))
   ((Label start)
    (Seq
      (Assign $tmp.1 (Prim Read ()))
      (IfStmt
        (op Eq)
        (arg1 (Var $tmp.1))
        (arg2 (Int 1))
        (jump_then (Label block_3))
        (jump_else (Label block_2)))))))
