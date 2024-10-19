(CProgram
  (Info
    (locals_types
      ((z.1 Integer)
       (x.1 Integer)
       (y.1 Integer))))
  (((Label start)
    (Seq
      (Assign z.1 (Atm (Int 22)))
      (Seq
        (Assign x.1 (Atm (Var z.1)))
        (Seq
          (Assign y.1 (Atm (Int 20)))
          (Return (Add (Var x.1) (Var y.1)))))))))
