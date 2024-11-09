(CProgram
  (Info (locals_types ()))
  (((Label start)
    (Seq
      (Assign x.1 (Prim Read ()))
      (Seq
        (Assign y.1 (Prim Read ()))
        (Seq
          (Assign
            z.1
            (Prim Eq ((Var x.1) (Var y.1))))
          (IfStmt
            (op Eq)
            (arg1 (Var z.1))
            (arg2 (Bool true))
            (jump_then (Label block_1))
            (jump_else (Label block_2)))))))
   ((Label block_1)
    (Return (Atm (Int 42))))
   ((Label block_2)
    (Return (Atm (Int 77))))))
