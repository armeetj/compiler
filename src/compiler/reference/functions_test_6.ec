(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign f.1 (FunRef (Label id) 1))
            (TailCall (Var f.1) ((Int 42)))))))))
   (Def
     (Label id)
     ((args ((x.1 Integer)))
      (ret Integer)
      (locals ())
      (body
        (((Label start) (Return (Atm (Var x.1))))))))))
