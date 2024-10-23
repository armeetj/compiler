(CProgram
  (Info
    (locals_types
      (($tmp.1 Integer) (x.1 Integer))))
  (((Label start)
    (Seq
      (Assign $tmp.1 (Negate (Int 10)))
      (Seq
        (Assign x.1 (Add (Int 42) (Var $tmp.1)))
        (Return (Add (Var x.1) (Int 10))))))))
