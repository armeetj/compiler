(CProgram
  (Info
    (locals_types
      (($tmp.1 Integer)
       ($tmp.2 Integer)
       ($tmp.3 Integer))))
  (((Label start)
    (Seq
      (Assign $tmp.1 Read)
      (Seq
        (Assign $tmp.2 (Negate (Var $tmp.1)))
        (Seq
          (Assign $tmp.3 Read)
          (Return (Add (Var $tmp.2) (Var $tmp.3)))))))))
