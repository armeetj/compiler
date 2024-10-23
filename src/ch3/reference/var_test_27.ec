(CProgram
  (Info (locals_types ((x.1 Integer))))
  (((Label start)
    (Seq
      (Assign x.1 Read)
      (Return (Add (Var x.1) (Var x.1)))))))
