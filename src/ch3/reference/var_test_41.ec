(CProgram
  (Info (locals_types ((x.1 Integer))))
  (((Label start)
    (Seq
      (Assign x.1 (Atm (Int 41)))
      (Return (Add (Var x.1) (Int 1)))))))
