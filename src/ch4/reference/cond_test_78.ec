(CProgram
  (Info (locals_types ()))
  (((Label start)
    (Seq
      (Assign x.1 (Prim Read ()))
      (Seq
        (Assign y.1 (Prim Read ()))
        (Seq
          (Assign z.1 (Prim Read ()))
          (Seq
            (Assign
              w.1
              (Prim Add ((Var z.1) (Var z.1))))
            (IfStmt
              (op Eq)
              (arg1 (Var z.1))
              (arg2 (Int 0))
              (jump_then (Label block_2))
              (jump_else (Label block_3))))))))
   ((Label block_2)
    (Seq
      (Assign $tmp.1 (Atm (Var x.1)))
      (Goto (Label block_1))))
   ((Label block_3)
    (Seq
      (Assign $tmp.1 (Atm (Var y.1)))
      (Goto (Label block_1))))
   ((Label block_1)
    (Return
      (Prim Add ((Var w.1) (Var $tmp.1)))))))
