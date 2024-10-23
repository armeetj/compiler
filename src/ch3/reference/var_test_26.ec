(CProgram
  (Info
    (locals_types
      (($tmp.1 Integer) ($tmp.2 Integer))))
  (((Label start)
    (Seq
      (Assign $tmp.1 Read)
      (Seq
        (Assign
          $tmp.2
          (Add (Var $tmp.1) (Int 10)))
        (Return (Negate (Var $tmp.2))))))))
