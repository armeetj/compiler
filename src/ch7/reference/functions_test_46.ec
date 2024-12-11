(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.1 (FunRef (Label sub1) 1))
            (TailCall (Var $tmp.1) ((Int 43)))))))))
   (Def
     (Label sub1)
     ((args ((x.1 Integer)))
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Return (Prim Sub ((Var x.1) (Int 1)))))))))))
