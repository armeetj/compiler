(CProgram
  (Info
    (locals_types
      ((x.1 Integer)
       (y.1 Integer)
       (z.1 Integer)
       (w.1 Integer))))
  (((Label start)
    (Seq
      (Assign x.1 (Atm (Int 10)))
      (Seq
        (Assign y.1 (Atm (Int 15)))
        (Seq
          (Assign z.1 (Add (Var y.1) (Var y.1)))
          (Seq
            (Assign w.1 (Add (Int 2) (Var z.1)))
            (Return (Add (Var w.1) (Var x.1))))))))))
