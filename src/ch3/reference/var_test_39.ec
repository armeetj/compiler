(CProgram
  (Info (locals_types (($tmp.1 Integer))))
  (((Label start)
    (Seq
      (Assign $tmp.1 (Negate (Int 5)))
      (Return (Sub (Int 47) (Var $tmp.1)))))))
