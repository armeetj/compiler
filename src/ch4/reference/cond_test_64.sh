(Program
  (Let
    x
    (If
      (Let
        x
        (Bool true)
        (If (Var x) (Var x) (Bool false)))
      (Bool true)
      (Bool false))
    (If (Var x) (Int 42) (Int 777))))
