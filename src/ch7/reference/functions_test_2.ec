(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.1 (FunRef (Label add) 2))
            (TailCall
              (Var $tmp.1)
              ((Int 40) (Int 2)))))))))
   (Def
     (Label add)
     ((args ((x.1 Integer) (y.1 Integer)))
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Return
            (Prim Add ((Var x.1) (Var y.1)))))))))))
