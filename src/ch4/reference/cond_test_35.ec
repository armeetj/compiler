(CProgram
  (Info (locals_types ()))
  (((Label start)
    (Seq
      (Assign $tmp.1 (Prim Read ()))
      (Seq
        (Assign
          $tmp.2
          (Prim Sub ((Var $tmp.1) (Int 2))))
        (Seq
          (Assign $tmp.3 (Prim Read ()))
          (Seq
            (Assign
              $tmp.4
              (Prim Add ((Var $tmp.3) (Int 2))))
            (IfStmt
              (op Le)
              (arg1 (Var $tmp.2))
              (arg2 (Var $tmp.4))
              (jump_then (Label block_1))
              (jump_else (Label block_2))))))))
   ((Label block_1)
    (Return (Atm (Int 42))))
   ((Label block_2) (Return (Atm (Int 0))))))
