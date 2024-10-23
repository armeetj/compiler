(CProgram
  (Info
    (locals_types
      ((c.1 Integer)
       (b.1 Integer)
       (a.1 Integer))))
  (((Label start)
    (Seq
      (Assign c.1 (Atm (Int 1)))
      (Seq
        (Assign b.1 (Atm (Var c.1)))
        (Seq
          (Assign a.1 (Atm (Var b.1)))
          (Return (Atm (Var a.1)))))))))
