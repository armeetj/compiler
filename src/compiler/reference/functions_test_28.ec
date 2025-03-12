(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.1 (FunRef (Label id) 1))
            (TailCall (Var $tmp.1) ((Int 0)))))))))
   (Def
     (Label id)
     ((args ((x.1 Integer)))
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var x.1))
            (arg2 (Int 0))
            (jump_then (Label block_1))
            (jump_else (Label block_2))))
         ((Label block_1) (Return (Atm (Int 0))))
         ((Label block_2)
          (Return (Atm (Int 42))))))))))
