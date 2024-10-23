(CProgram
  (Info
    (locals_types
      ((x.1 Integer) (y.1 Integer))))
  (((Label start)
    (Seq
      (Assign x.1 (Atm (Int 42)))
      (Seq
        (Assign y.1 (Atm (Var x.1)))
        (Return (Atm (Var y.1))))))))
