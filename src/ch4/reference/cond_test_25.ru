(CProgram
  (Info
    (locals_types
      (($tmp.1 Integer)
       ($tmp.2 Boolean)
       (x.1 Integer))))
  (((Label block_1)
    (Return (Atm (Int 77))))
   ((Label block_2)
    (Return (Atm (Int 42))))
   ((Label start)
    (Seq
      (Assign x.1 (Atm (Int 1)))
      (Seq
        (Assign $tmp.1 (Prim Read ()))
        (Seq
          (Assign
            $tmp.2
            (Prim Eq ((Var x.1) (Var $tmp.1))))
          (IfStmt
            (op Eq)
            (arg1 (Var $tmp.2))
            (arg2 (Bool false))
            (jump_then (Label block_1))
            (jump_else (Label block_2)))))))))
