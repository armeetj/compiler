(CProgram
  (Info
    (locals_types
      ((x.1 Integer) ($tmp.1 Integer))))
  (((Label start)
    (Seq
      (Assign x.1 (Atm (Int 14)))
      (Seq
        (Assign
          $tmp.1
          (Add (Var x.1) (Var x.1)))
        (Return (Add (Var $tmp.1) (Var x.1))))))))
