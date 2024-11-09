(CProgram
  (Info
    (locals_types
      ((x.1 Integer) (y.1 Integer))))
  (((Label block_1)
    (Return (Prim Add ((Var y.1) (Int 2)))))
   ((Label start)
    (Seq
      (Assign y.1 (Prim Read ()))
      (Goto (Label block_1))))))
