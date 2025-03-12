(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($tmp.1 (Function (Integer) Unit))
         (f (Function (Integer) Unit))
         (y.1 Integer)))
      (body
        (((Label start)
          (Seq
            (Assign y.1 (Atm (Int 42)))
            (Seq
              (Assign $tmp.1 (FunRef (Label f) 1))
              (Seq
                (CallS (Var $tmp.1) ((Var y.1)))
                (Return (Atm (Var y.1)))))))))))
   (Def
     (Label f)
     ((args ((x.1 Integer)))
      (ret Unit)
      (locals ((x.1 Integer)))
      (body
        (((Label start)
          (Seq
            (Assign x.1 (Atm (Int 0)))
            (Return (Atm Void))))))))))
