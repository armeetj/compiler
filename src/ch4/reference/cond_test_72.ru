(CProgram
  (Info (locals_types (($tmp.1 Integer))))
  (((Label block_1)
    (Return
      (Prim Add ((Var $tmp.1) (Int 1)))))
   ((Label start)
    (Seq
      (Assign $tmp.1 (Atm (Int 41)))
      (Goto (Label block_1))))))
