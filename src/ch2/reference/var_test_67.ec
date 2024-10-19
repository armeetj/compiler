(CProgram
  (Info
    (locals_types
      ((a.1 Integer)
       (b.1 Integer)
       (c.1 Integer)
       ($tmp.1 Integer))))
  (((Label start)
    (Seq
      (Assign a.1 Read)
      (Seq
        (Assign b.1 Read)
        (Seq
          (Assign c.1 Read)
          (Seq
            (Assign
              $tmp.1
              (Add (Var a.1) (Var b.1)))
            (Return (Add (Var $tmp.1) (Var c.1))))))))))
