(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($tmp.1 (Function (Integer) Integer))
         ($tmp.2 Integer)
         ($tmp.3
           (Function
             ((Function (Integer) Integer) Integer)
             Integer))
         (apply
           (Function
             ((Function (Integer) Integer) Integer)
             Integer))
         (inc (Function (Integer) Integer))))
      (body
        (((Label start)
          (Seq
            (Assign $tmp.3 (FunRef (Label apply) 2))
            (Seq
              (Assign $tmp.1 (FunRef (Label inc) 1))
              (Seq
                (Assign $tmp.2 (Prim Read ()))
                (TailCall
                  (Var $tmp.3)
                  ((Var $tmp.1) (Var $tmp.2)))))))))))
   (Def
     (Label apply)
     ((args
        ((f.1 (Function (Integer) Integer))
         (x.1 Integer)))
      (ret Integer)
      (locals
        (($tmp.4 Integer)
         (f.1 (Function (Integer) Integer))
         (x.1 Integer)))
      (body
        (((Label start)
          (Seq
            (Assign
              $tmp.4
              (Call (Var f.1) ((Var x.1))))
            (TailCall (Var f.1) ((Var $tmp.4)))))))))
   (Def
     (Label inc)
     ((args ((x.2 Integer)))
      (ret Integer)
      (locals ((x.2 Integer)))
      (body
        (((Label start)
          (Return (Prim Add ((Var x.2) (Int 1)))))))))))
