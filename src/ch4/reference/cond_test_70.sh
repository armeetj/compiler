(Program
  (If
    (If
      (Bool false)
      (Prim Eq ((Prim Read ()) (Int 42)))
      (Bool false))
    (Int 777)
    (Int 42)))
