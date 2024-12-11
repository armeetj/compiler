(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($tmp.1
           (Function (Integer Integer) Integer))
         (add
           (Function (Integer Integer) Integer))))
      (body
        (((Label start)
          (Seq
            (Assign $tmp.1 (FunRef (Label add) 2))
            (TailCall
              (Var $tmp.1)
              ((Int 20) (Int 22)))))))))
   (Def
     (Label add)
     ((args ((x.1 Integer) (y.1 Integer)))
      (ret Integer)
      (locals ((x.1 Integer) (y.1 Integer)))
      (body
        (((Label start)
          (Return
            (Prim Add ((Var x.1) (Var y.1)))))))))))
