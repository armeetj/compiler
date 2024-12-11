(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($tmp.1
           (Function
             (Integer)
             (Function
               (Integer)
               (Function
                 (Integer)
                 (Function (Integer) Integer)))))
         ($tmp.2
           (Function
             (Integer)
             (Function
               (Integer)
               (Function (Integer) Integer))))
         ($tmp.3
           (Function
             (Integer)
             (Function (Integer) Integer)))
         ($tmp.4 (Function (Integer) Integer))
         (rrrid
           (Function
             (Integer)
             (Function
               (Integer)
               (Function
                 (Integer)
                 (Function (Integer) Integer)))))))
      (body
        (((Label start)
          (Seq
            (Assign $tmp.1 (FunRef (Label rrrid) 1))
            (Seq
              (Assign
                $tmp.2
                (Call (Var $tmp.1) ((Int 0))))
              (Seq
                (Assign
                  $tmp.3
                  (Call (Var $tmp.2) ((Int 0))))
                (Seq
                  (Assign
                    $tmp.4
                    (Call (Var $tmp.3) ((Int 0))))
                  (TailCall (Var $tmp.4) ((Int 42))))))))))))
   (Def
     (Label id)
     ((args ((x.1 Integer)))
      (ret Integer)
      (locals ((x.1 Integer)))
      (body
        (((Label start) (Return (Atm (Var x.1))))))))
   (Def
     (Label rid)
     ((args ((x.2 Integer)))
      (ret (Function (Integer) Integer))
      (locals
        ((id (Function (Integer) Integer))))
      (body
        (((Label start)
          (Return (FunRef (Label id) 1)))))))
   (Def
     (Label rrid)
     ((args ((x.3 Integer)))
      (ret
        (Function
          (Integer)
          (Function (Integer) Integer)))
      (locals
        ((rid
           (Function
             (Integer)
             (Function (Integer) Integer)))))
      (body
        (((Label start)
          (Return (FunRef (Label rid) 1)))))))
   (Def
     (Label rrrid)
     ((args ((x.4 Integer)))
      (ret
        (Function
          (Integer)
          (Function
            (Integer)
            (Function (Integer) Integer))))
      (locals
        ((rrid
           (Function
             (Integer)
             (Function
               (Integer)
               (Function (Integer) Integer))))))
      (body
        (((Label start)
          (Return (FunRef (Label rrid) 1)))))))))
