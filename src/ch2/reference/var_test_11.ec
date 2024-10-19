(CProgram
  (Info
    (locals_types
      ((x.1 Integer)
       (x.2 Integer)
       (y.1 Integer))))
  (((Label start)
    (Seq
      (Assign x.1 (Atm (Int 20)))
      (Seq
        (Assign x.2 (Atm (Int 22)))
        (Seq
          (Assign y.1 (Add (Var x.1) (Var x.2)))
          (Return (Atm (Var y.1)))))))))
