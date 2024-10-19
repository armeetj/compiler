(CProgram
  (Info
    (locals_types
      ((a.1 Integer)
       (b.1 Integer)
       (c.1 Integer)
       (d.1 Integer))))
  (((Label start)
    (Seq
      (Assign a.1 Read)
      (Seq
        (Assign b.1 (Atm (Var a.1)))
        (Seq
          (Assign c.1 (Atm (Var b.1)))
          (Seq
            (Assign d.1 (Atm (Var c.1)))
            (Return (Atm (Var d.1))))))))))
