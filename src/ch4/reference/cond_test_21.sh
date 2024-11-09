(Program
  (If
    (If
      (Prim Eq ((Prim Read ()) (Int 0)))
      (Prim Eq ((Prim Read ()) (Int 1)))
      (Bool false))
    (Int 0)
    (Int 42)))
