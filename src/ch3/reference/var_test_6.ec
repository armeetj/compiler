(CProgram
  (Info
    (locals_types
      ((x.1 Integer) (y.1 Integer))))
  (((Label start)
    (Seq
      (Assign x.1 (Atm (Int 20)))
      (Seq
        (Assign y.1 (Atm (Int 22)))
        (Return (Add (Var x.1) (Var y.1))))))))
