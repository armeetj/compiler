(CProgram
  (Info
    (locals_types
      ((v.1 Integer)
       (w.1 Integer)
       (x.1 Integer)
       (y.1 Integer)
       (z.1 Integer)
       ($tmp.1 Integer))))
  (((Label start)
    (Seq
      (Assign v.1 (Atm (Int 1)))
      (Seq
        (Assign w.1 (Atm (Int 42)))
        (Seq
          (Assign x.1 (Add (Var v.1) (Int 7)))
          (Seq
            (Assign y.1 (Atm (Var x.1)))
            (Seq
              (Assign z.1 (Add (Var x.1) (Var w.1)))
              (Seq
                (Assign $tmp.1 (Negate (Var y.1)))
                (Return (Add (Var z.1) (Var $tmp.1))))))))))))
