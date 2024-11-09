(CProgram
  (Info (locals_types ()))
  (((Label start)
    (Seq
      (Assign y.1 (Prim Read ()))
      (Goto (Label block_1))))
   ((Label block_2)
    (Seq
      (Assign y.1 (Atm (Int 77)))
      (Goto (Label block_1))))
   ((Label block_3)
    (Seq
      (Assign x.1 (Prim Read ()))
      (Seq
        (Assign
          y.1
          (Prim Add ((Int 1) (Var x.1))))
        (Goto (Label block_1)))))
   ((Label block_1)
    (Return (Prim Add ((Var y.1) (Int 2)))))))
