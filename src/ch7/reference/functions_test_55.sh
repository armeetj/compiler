(Program
  ((Def
     main
     ((args ())
      (ret Integer)
      (body
        (Let
          y
          (Int 42)
          (Begin
            ((Apply (Var f) ((Var y))))
            (Var y))))))
   (Def
     f
     ((args ((x Integer)))
      (ret Unit)
      (body
        (Begin ((SetBang x (Int 0))) Void))))))
