(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($tmp.1 (Function (Integer) Integer))
         ($tmp.2 Integer)
         (id (Function (Integer) Integer))))
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
      (locals ((x.1 Integer)))
      (body
        (((Label start) (Return (Atm (Var x.1))))))))))
