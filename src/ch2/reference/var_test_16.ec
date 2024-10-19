(CProgram
  (Info (locals_types (($tmp.1 Integer))))
  (((Label start)
    (Seq
      (Assign $tmp.1 (Add (Int 30) (Int 10)))
      (Return (Add (Var $tmp.1) (Int 2)))))))
