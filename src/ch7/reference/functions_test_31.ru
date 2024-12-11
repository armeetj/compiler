(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        ((fun.1 (Function (Integer) Integer))
         (id (Function (Integer) Integer))))
      (body
        (((Label start)
          (Seq
            (Assign fun.1 (FunRef (Label id) 1))
            (TailCall (Var fun.1) ((Int 42)))))))))
   (Def
     (Label id)
     ((args ((x.1 Integer)))
      (ret Integer)
      (locals ((x.1 Integer)))
      (body
        (((Label start) (Return (Atm (Var x.1))))))))))
