(CProgram
  (Info
    (locals_types
      ((x.1 Integer)
       (y.1 Integer)
       ($tmp.1 Integer))))
  (((Label start)
    (Seq
      (Assign x.1 Read)
      (Seq
        (Assign y.1 Read)
        (Seq
          (Assign
            $tmp.1
            (Add (Var x.1) (Var y.1)))
          (Return (Add (Var $tmp.1) (Int 42)))))))))
