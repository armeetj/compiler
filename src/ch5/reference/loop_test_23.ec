(CProgram
  (Info (locals_types ()))
  (((Label start)
    (Seq
      (Assign x.1 (Atm (Int 0)))
      (Seq
        (Assign y.1 (Atm Void))
        (Seq
          (Assign x.1 (Atm (Int 42)))
          (Seq
            (Assign z.1 (Atm (Var y.1)))
            (Return (Atm (Var x.1))))))))))
