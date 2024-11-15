(Program
  (Let
    x
    (Int 10)
    (Let
      y
      (Int 0)
      (Prim
        Add
        ((Prim
           Add
           ((Begin
              ((SetBang y (Prim Read ())))
              (Var x))
            (Begin
              ((SetBang x (Prim Read ())))
              (Var y))))
         (Var x))))))
