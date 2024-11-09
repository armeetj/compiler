(CProgram
  (Info
    (locals_types
      (($tmp.1 Boolean)
       (x.1 Integer)
       (y.1 Boolean))))
  (((Label block_1)
    (Return (Atm (Int 42))))
   ((Label block_2)
    (Return (Atm (Int 77))))
   ((Label start)
    (Seq
      (Assign x.1 (Prim Read ()))
      (Seq
        (Assign
          $tmp.1
          (Prim Eq ((Var x.1) (Int 0))))
        (Seq
          (Assign y.1 (Prim Not ((Var $tmp.1))))
          (IfStmt
            (op Eq)
            (arg1 (Var y.1))
            (arg2 (Bool true))
            (jump_then (Label block_1))
            (jump_else (Label block_2)))))))))
