(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.3 (FunRef (Label twice) 2))
            (Seq
              (Assign $tmp.1 (FunRef (Label add1) 1))
              (Seq
                (Assign $tmp.2 (Prim Read ()))
                (TailCall
                  (Var $tmp.3)
                  ((Var $tmp.1) (Var $tmp.2)))))))))))
   (Def
     (Label add1)
     ((args ((y.1 Integer)))
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Return (Prim Add ((Int 1) (Var y.1)))))))))
   (Def
     (Label twice)
     ((args
        ((f.1 (Function (Integer) Integer))
         (x.1 Integer)))
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign
              $tmp.4
              (Call (Var f.1) ((Var x.1))))
            (Seq
              (Assign
                $tmp.5
                (Call (Var f.1) ((Var x.1))))
              (Return
                (Prim Add ((Var $tmp.4) (Var $tmp.5)))))))))))))
