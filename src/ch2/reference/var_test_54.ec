(CProgram
  (Info
    (locals_types
      ((x.1 Integer)
       (x.2 Integer)
       (x.3 Integer))))
  (((Label start)
    (Seq
      (Assign x.1 (Atm (Int 99)))
      (Seq
        (Assign x.2 (Atm (Int 22)))
        (Seq
          (Assign x.3 (Atm (Int 42)))
          (Return (Atm (Var x.3)))))))))
