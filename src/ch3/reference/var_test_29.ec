(CProgram
  (Info (locals_types ((x.1 Integer))))
  (((Label start)
    (Seq
      (Assign x.1 Read)
      (Return (Atm (Int 42)))))))
