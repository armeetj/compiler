(CProgram
  (Info (locals_types ()))
  (((Label start) (Return (Atm (Int 42))))
   ((Label block_1)
    (Seq
      (Assign $tmp.2 (Atm (Var x.1)))
      (Seq
        (Assign
          x.1
          (Prim Add ((Var $tmp.2) (Int 1))))
        (Goto (Label loop_1)))))
   ((Label block_2)
    (Return (Atm (Var x.1))))
   ((Label loop_1)
    (Seq
      (Assign $tmp.1 (Atm (Var x.1)))
      (IfStmt
        (op Lt)
        (arg1 (Var $tmp.1))
        (arg2 (Int 1))
        (jump_then (Label block_1))
        (jump_else (Label block_2)))))))
