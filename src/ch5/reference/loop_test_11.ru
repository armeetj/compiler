(CProgram
  (Info
    (locals_types
      (($tmp.1 Integer)
       ($tmp.2 Integer)
       ($tmp.3 Integer)
       (x.1 Integer))))
  (((Label block_1)
    (Seq
      (Assign $tmp.2 (Atm (Var x.1)))
      (Seq
        (Assign
          x.1
          (Prim Sub ((Var $tmp.2) (Int 2))))
        (Goto (Label loop_1)))))
   ((Label block_2)
    (Seq
      (Assign $tmp.3 (Atm (Var x.1)))
      (Return
        (Prim Add ((Var $tmp.3) (Int 42))))))
   ((Label loop_1)
    (Seq
      (Assign $tmp.1 (Atm (Var x.1)))
      (IfStmt
        (op Gt)
        (arg1 (Var $tmp.1))
        (arg2 (Int 0))
        (jump_then (Label block_1))
        (jump_else (Label block_2)))))
   ((Label start)
    (Seq
      (Assign x.1 (Prim Read ()))
      (Goto (Label loop_1))))))
