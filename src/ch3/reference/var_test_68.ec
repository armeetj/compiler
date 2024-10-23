(CProgram
  (Info
    (locals_types
      ((x.1 Integer)
       (y.1 Integer)
       (z.1 Integer)
       ($tmp.1 Integer))))
  (((Label start)
    (Seq
      (Assign x.1 (Atm (Int 30)))
      (Seq
        (Assign y.1 Read)
        (Seq
          (Assign z.1 Read)
          (Seq
            (Assign
              $tmp.1
              (Sub (Var z.1) (Var y.1)))
            (Return (Add (Var x.1) (Var $tmp.1))))))))))
