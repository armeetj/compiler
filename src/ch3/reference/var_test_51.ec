(CProgram
  (Info
    (locals_types
      (($tmp.1 Integer)
       ($tmp.2 Integer)
       (x.1 Integer))))
  (((Label start)
    (Seq
      (Assign $tmp.1 Read)
      (Seq
        (Assign $tmp.2 Read)
        (Seq
          (Assign
            x.1
            (Add (Var $tmp.1) (Var $tmp.2)))
          (Return (Atm (Var x.1)))))))))
