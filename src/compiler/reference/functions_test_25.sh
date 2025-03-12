(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Apply
          (Apply
            (Var f)
            ((Vec
               ((Var id))
               ((Vector ((Function (Integer) Integer)))))))
          ((Int 42))))))
   (Def
     id
     ((args ((x Integer)))
      (ret Integer)
      (body (Var x))))
   (Def
     f
     ((args
        ((v
           (Vector ((Function (Integer) Integer))))))
      (ret (Function (Integer) Integer))
      (body (VecRef (Var v) 0))))))
