(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($tmp.1 (Function (Integer) Integer))
         (sub1 (Function (Integer) Integer))))
      (body
        (((Label start)
          (Seq
            (Assign $tmp.1 (FunRef (Label sub1) 1))
            (TailCall (Var $tmp.1) ((Int 43)))))))))
   (Def
     (Label sub1)
     ((args ((x.1 Integer)))
      (ret Integer)
      (locals ((x.1 Integer)))
      (body
        (((Label start)
          (Return (Prim Sub ((Var x.1) (Int 1)))))))))))
