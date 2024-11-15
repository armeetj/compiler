(CProgram
  (Info (locals_types ()))
  (((Label start)
    (Seq
      (Assign x.1 (Atm (Int 1)))
      (Seq
        (Assign x.1 (Atm (Int 42)))
        (Goto (Label block_1)))))
   ((Label block_1)
    (Return (Atm (Var x.1))))))
