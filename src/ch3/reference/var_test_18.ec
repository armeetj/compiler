(CProgram
  (Info
    (locals_types
      (($tmp.1 Integer) ($tmp.2 Integer))))
  (((Label start)
    (Seq
      (Assign $tmp.1 (Add (Int 7) (Int 3)))
      (Seq
        (Assign $tmp.2 (Negate (Var $tmp.1)))
        (Return (Add (Int 52) (Var $tmp.2))))))))
