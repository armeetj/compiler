(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.1 (FunRef (Label id) 1))
            (Seq
              (Assign
                $tmp.2
                (Call (Var $tmp.1) ((Int 41))))
              (Return
                (Prim Add ((Int 1) (Var $tmp.2)))))))))))
   (Def
     (Label id)
     ((args ((x.1 Integer)))
      (ret Integer)
      (locals ())
      (body
        (((Label start) (Return (Atm (Var x.1))))))))))
