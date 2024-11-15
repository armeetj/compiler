(CProgram
  (Info
    (locals_types
      (($tmp.1 Integer)
       ($tmp.2 Integer)
       (i.1 Integer))))
  (((Label block_1)
    (Seq
      (Assign $tmp.2 (Atm (Var i.1)))
      (Seq
        (Assign
          i.1
          (Prim Sub ((Var $tmp.2) (Int 1))))
        (Goto (Label loop_1)))))
   ((Label block_2)
    (Return (Atm (Int 42))))
   ((Label loop_1)
    (Seq
      (Assign $tmp.1 (Atm (Var i.1)))
      (IfStmt
        (op Gt)
        (arg1 (Var $tmp.1))
        (arg2 (Int 0))
        (jump_then (Label block_1))
        (jump_else (Label block_2)))))
   ((Label start)
    (Seq
      (Assign i.1 (Atm (Int 2)))
      (Goto (Label loop_1))))))
