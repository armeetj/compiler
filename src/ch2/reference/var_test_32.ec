(CProgram
  (Info
    (locals_types
      ((b.1 Integer) (c.1 Integer))))
  (((Label start)
    (Seq
      (Assign b.1 Read)
      (Seq
        (Assign c.1 Read)
        (Return (Add (Var b.1) (Var c.1))))))))
