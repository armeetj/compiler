(CProgram
  (Info (locals_types ()))
  (((Label start)
    (Seq
      (Assign x.1 (Prim Read ()))
      (Seq
        (Assign y.1 (Prim Read ()))
        (Seq
          (Assign $tmp.1 (Prim Read ()))
          (IfStmt
            (op Eq)
            (arg1 (Var $tmp.1))
            (arg2 (Int 0))
            (jump_then (Label block_2))
            (jump_else (Label block_3)))))))
   ((Label block_2)
    (Seq
      (Assign
        z.1
        (Prim Add ((Var x.1) (Int 1))))
      (Goto (Label block_1))))
   ((Label block_3)
    (Seq
      (Assign
        z.1
        (Prim Add ((Var y.1) (Int 2))))
      (Goto (Label block_1))))
   ((Label block_1)
    (Seq
      (Assign
        $tmp.2
        (Prim Negate ((Var z.1))))
      (Return
        (Prim Add ((Int 45) (Var $tmp.2))))))))
