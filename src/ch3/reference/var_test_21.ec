(CProgram
  (Info
    (locals_types
      ((x.1 Integer)
       (z.1 Integer)
       (y.1 Integer)
       ($tmp.1 Integer))))
  (((Label start)
    (Seq
      (Assign x.1 (Atm (Int 30)))
      (Seq
        (Assign z.1 (Add (Var x.1) (Int 14)))
        (Seq
          (Assign y.1 (Atm (Int 2)))
          (Seq
            (Assign $tmp.1 (Negate (Var y.1)))
            (Return (Add (Var z.1) (Var $tmp.1))))))))))
