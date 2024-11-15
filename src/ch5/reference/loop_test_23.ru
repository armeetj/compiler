(CProgram
  (Info
    (locals_types
      ((x.1 Integer) (y.1 Unit) (z.1 Unit))))
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
