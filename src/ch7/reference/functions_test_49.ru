(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($tmp.1 (Function () Boolean))
         ($tmp.2 (Function () Integer))
         ($tmp.3 (Function () Integer))
         ($tmp.4 Integer)
         ($tmp.5 (Function (Integer) Integer))
         (apply_1 Boolean)
         (g (Function () Boolean))
         (h (Function () Integer))
         (k (Function () Integer))
         (l (Function (Integer) Integer))))
      (body
        (((Label block_1)
          (Seq
            (Assign $tmp.2 (FunRef (Label h) 0))
            (TailCall (Var $tmp.2) ())))
         ((Label block_2)
          (Seq
            (Assign $tmp.5 (FunRef (Label l) 1))
            (Seq
              (Assign $tmp.3 (FunRef (Label k) 0))
              (Seq
                (Assign $tmp.4 (Call (Var $tmp.3) ()))
                (TailCall (Var $tmp.5) ((Var $tmp.4)))))))
         ((Label start)
          (Seq
            (Assign $tmp.1 (FunRef (Label g) 0))
            (Seq
              (Assign apply_1 (Call (Var $tmp.1) ()))
              (IfStmt
                (op Eq)
                (arg1 (Var apply_1))
                (arg2 (Bool true))
                (jump_then (Label block_1))
                (jump_else (Label block_2))))))))))
   (Def
     (Label g)
     ((args ())
      (ret Boolean)
      (locals ())
      (body
        (((Label start)
          (Return (Atm (Bool false))))))))
   (Def
     (Label h)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start) (Return (Atm (Int 777))))))))
   (Def
     (Label k)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start) (Return (Atm (Int 41))))))))
   (Def
     (Label l)
     ((args ((y.1 Integer)))
      (ret Integer)
      (locals ((y.1 Integer)))
      (body
        (((Label start)
          (Return (Prim Add ((Var y.1) (Int 1)))))))))))