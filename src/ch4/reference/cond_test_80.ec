(CProgram
  (Info (locals_types ()))
  (((Label start)
    (Seq
      (Assign y.1 (Prim Read ()))
      (IfStmt
        (op Eq)
        (arg1 (Var y.1))
        (arg2 (Int 0))
        (jump_then (Label block_2))
        (jump_else (Label block_3)))))
   ((Label block_2)
    (Seq
      (Assign x.1 (Atm (Int 40)))
      (Goto (Label block_1))))
   ((Label block_3)
    (Seq
      (Assign x.1 (Atm (Int 77)))
      (Goto (Label block_1))))
   ((Label block_1)
    (Return (Prim Add ((Var x.1) (Int 2)))))))
