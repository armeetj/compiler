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
            (TailCall (Var $tmp.1) ((Int 42)))))))))
   (Def
     (Label id)
     ((args ((x.1 Integer)))
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Return (Prim Add ((Var x.1) (Int 1)))))))))))
