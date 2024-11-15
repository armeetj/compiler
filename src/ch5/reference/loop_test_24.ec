(CProgram
  (Info (locals_types ()))
  (((Label start)
    (Seq
      (Assign x.1 (Prim Read ()))
      (Seq
        (Assign $tmp.1 (Atm (Var x.1)))
        (Seq
          (Assign x.1 (Atm (Int 40)))
          (Seq
            (Assign $tmp.2 (Atm (Var x.1)))
            (Return
              (Prim Add ((Var $tmp.1) (Var $tmp.2)))))))))))
