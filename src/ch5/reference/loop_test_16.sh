(Program
  (Let
    x
    (Int 1)
    (Begin
      ((If
         (Bool true)
         (SetBang x (Int 42))
         (SetBang x (Int 0))))
      (Var x))))
