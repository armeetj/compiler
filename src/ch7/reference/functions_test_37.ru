(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start) (Return (Atm (Int 42))))))))
   (Def
     (Label bluh)
     ((args ())
      (ret (Function (Integer) Integer))
      (locals
        (($tmp.1
           (Function
             ()
             (Function (Integer) Integer)))
         (bluh
           (Function
             ()
             (Function (Integer) Integer)))))
      (body
        (((Label start)
          (Seq
            (Assign $tmp.1 (FunRef (Label bluh) 0))
            (TailCall (Var $tmp.1) ())))))))))
