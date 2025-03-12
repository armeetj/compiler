(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign
              $tmp.1
              (FunRef (Label give_me_add1) 0))
            (Seq
              (Assign $tmp.2 (Call (Var $tmp.1) ()))
              (TailCall (Var $tmp.2) ((Int 41))))))))))
   (Def
     (Label add1)
     ((args ((x.1 Integer)))
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Return (Prim Add ((Var x.1) (Int 1)))))))))
   (Def
     (Label give_me_add1)
     ((args ())
      (ret (Function (Integer) Integer))
      (locals ())
      (body
        (((Label start)
          (Return (FunRef (Label add1) 1)))))))))
