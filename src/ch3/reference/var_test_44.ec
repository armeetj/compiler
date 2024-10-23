(CProgram
  (Info
    (locals_types
      ((x.1 Integer) (x.2 Integer))))
  (((Label start)
    (Seq
      (Assign x.1 (Atm (Int 20)))
      (Seq
        (Assign x.2 (Atm (Int 22)))
        (Return (Sub (Var x.2) (Var x.1))))))))
