(Program
  (Let
    x
    (Int 0)
    (Let
      y
      (SetBang x (Int 42))
      (Let z (Var y) (Var x)))))
