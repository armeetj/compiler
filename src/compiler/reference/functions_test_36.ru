(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($tmp.1 (Function (Integer) Integer))
         (uhoh (Function (Integer) Integer))))
      (body
        (((Label start)
          (Seq
            (Assign $tmp.1 (FunRef (Label uhoh) 1))
            (TailCall (Var $tmp.1) ((Int 42)))))))))
   (Def
     (Label uhoh)
     ((args ((x.1 Integer)))
      (ret Integer)
      (locals
        (($tmp.2 (Function (Integer) Integer))
         (uhoh (Function (Integer) Integer))
         (x.1 Integer)))
      (body
        (((Label block_1)
          (Seq
            (Assign $tmp.2 (FunRef (Label uhoh) 1))
            (TailCall (Var $tmp.2) ((Var x.1)))))
         ((Label block_2)
          (Return (Atm (Var x.1))))
         ((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var x.1))
            (arg2 (Int 0))
            (jump_then (Label block_1))
            (jump_else (Label block_2))))))))))
