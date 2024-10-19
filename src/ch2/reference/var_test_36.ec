(CProgram
  (Info
    (locals_types
      ((x.1 Integer)
       (y.1 Integer)
       (z.1 Integer)
       ($tmp.1 Integer)
       ($tmp.2 Integer))))
  (((Label start)
    (Seq
      (Assign x.1 Read)
      (Seq
        (Assign y.1 Read)
        (Seq
          (Assign z.1 Read)
          (Seq
            (Assign $tmp.1 (Negate (Var y.1)))
            (Seq
              (Assign
                $tmp.2
                (Add (Var z.1) (Var $tmp.1)))
              (Return (Add (Var x.1) (Var $tmp.2)))))))))))
