(CProgram
  (Info
    (locals_types
      (($tmp.1 Integer)
       ($tmp.2 Integer)
       ($tmp.3 Integer))))
  (((Label start)
    (Seq
      (Assign $tmp.1 (Add (Int 10) (Int 11)))
      (Seq
        (Assign $tmp.2 (Negate (Int 4)))
        (Seq
          (Assign
            $tmp.3
            (Add (Int 25) (Var $tmp.2)))
          (Return (Sub (Var $tmp.1) (Var $tmp.3)))))))))
