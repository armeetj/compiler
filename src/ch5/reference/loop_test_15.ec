(CProgram
  (Info (locals_types ()))
  (((Label start)
    (Seq
      (Assign x.1 (Atm (Int 0)))
      (Seq
        (Assign y.1 (Atm Void))
        (Seq
          (Assign x.1 (Atm (Int 1)))
          (Seq
            (Assign y.1 (Atm Void))
            (Seq
              (Assign x.1 (Atm (Int 42)))
              (Return (Atm (Var x.1)))))))))))
