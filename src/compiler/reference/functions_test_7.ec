(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.2 (FunRef (Label id) 1))
            (Seq
              (Assign $tmp.1 (FunRef (Label inc) 1))
              (Seq
                (Assign
                  $tmp.3
                  (Call (Var $tmp.2) ((Var $tmp.1))))
                (TailCall (Var $tmp.3) ((Int 41)))))))))))
   (Def
     (Label id)
     ((args
        ((f.1 (Function (Integer) Integer))))
      (ret (Function (Integer) Integer))
      (locals ())
      (body
        (((Label start) (Return (Atm (Var f.1))))))))
   (Def
     (Label inc)
     ((args ((x.1 Integer)))
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Return (Prim Add ((Var x.1) (Int 1)))))))))))
