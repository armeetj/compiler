(CProgram
  (Info
    (locals_types
      ((y.1 Integer) (x.1 Integer))))
  (((Label start)
    (Seq
      (Assign y.1 (Negate (Int 42)))
      (Seq
        (Assign x.1 (Atm (Var y.1)))
        (Return (Negate (Var x.1))))))))
