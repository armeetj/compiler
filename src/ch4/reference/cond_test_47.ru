(CProgram
  (Info
    (locals_types
      (($tmp.1 Integer)
       ($tmp.2 Integer)
       ($tmp.3 Integer)
       ($tmp.4 Integer))))
  (((Label block_1)
    (Return (Atm (Int 42))))
   ((Label block_2)
    (Return (Atm (Int 77))))
   ((Label block_3)
    (Seq
      (Assign $tmp.4 (Prim Read ()))
      (IfStmt
        (op Lt)
        (arg1 (Var $tmp.4))
        (arg2 (Int 0))
        (jump_then (Label block_1))
        (jump_else (Label block_2)))))
   ((Label start)
    (Seq
      (Assign $tmp.1 (Prim Read ()))
      (Seq
        (Assign
          $tmp.2
          (Prim Add ((Int 1) (Var $tmp.1))))
        (Seq
          (Assign $tmp.3 (Prim Read ()))
          (IfStmt
            (op Gt)
            (arg1 (Var $tmp.2))
            (arg2 (Var $tmp.3))
            (jump_then (Label block_3))
            (jump_else (Label block_2)))))))))
