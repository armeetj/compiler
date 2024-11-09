(CProgram
  (Info (locals_types ()))
  (((Label start)
    (Seq
      (Assign $tmp.1 (Atm (Int 41)))
      (Goto (Label block_1))))
   ((Label block_1)
    (Return
      (Prim Add ((Var $tmp.1) (Int 1)))))))
