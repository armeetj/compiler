(CProgram
  (Info
    (locals_types
      (($tmp.1 Integer)
       ($tmp.2 Integer)
       ($tmp.3 Integer)
       ($tmp.4 Integer)
       (x.1 Integer)
       (y.1 Integer))))
  (((Label start)
    (Seq
      (Assign x.1 (Atm (Int 10)))
      (Seq
        (Assign y.1 (Atm (Int 0)))
        (Seq
          (Assign y.1 (Prim Read ()))
          (Seq
            (Assign $tmp.1 (Atm (Var x.1)))
            (Seq
              (Assign x.1 (Prim Read ()))
              (Seq
                (Assign $tmp.2 (Atm (Var y.1)))
                (Seq
                  (Assign
                    $tmp.3
                    (Prim Add ((Var $tmp.1) (Var $tmp.2))))
                  (Seq
                    (Assign $tmp.4 (Atm (Var x.1)))
                    (Return
                      (Prim Add ((Var $tmp.3) (Var $tmp.4)))))))))))))))
