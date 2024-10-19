(CProgram
  (Info
    (locals_types
      ((a.1 Integer)
       (b.1 Integer)
       (f.1 Integer)
       (e.1 Integer)
       (d.1 Integer))))
  (((Label start)
    (Seq
      (Assign a.1 (Atm (Int 1)))
      (Seq
        (Assign b.1 (Atm (Int 42)))
        (Seq
          (Assign f.1 (Atm (Var b.1)))
          (Seq
            (Assign e.1 (Add (Var a.1) (Var b.1)))
            (Seq
              (Assign d.1 (Atm (Var f.1)))
              (Return (Atm (Var d.1)))))))))))
