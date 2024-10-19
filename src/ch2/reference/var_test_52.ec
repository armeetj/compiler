(CProgram
  (Info
    (locals_types
      ((x.1 Integer) (x.2 Integer))))
  (((Label start)
    (Seq
      (Assign x.1 (Atm (Int 10)))
      (Seq
        (Assign x.2 (Atm (Int 32)))
        (Return (Add (Var x.1) (Var x.2))))))))
