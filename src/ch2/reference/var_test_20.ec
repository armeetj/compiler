(CProgram
  (Info
    (locals_types
      ((a.1 Integer) (b.1 Integer))))
  (((Label start)
    (Seq
      (Assign a.1 (Atm (Int 42)))
      (Seq
        (Assign b.1 (Atm (Var a.1)))
        (Return (Atm (Var b.1))))))))
