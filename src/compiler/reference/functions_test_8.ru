(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($tmp.1 (Function (Integer) Boolean))
         (apply_1 Boolean)
         (even (Function (Integer) Boolean))))
      (body
        (((Label block_1)
          (Return (Atm (Int 42))))
         ((Label block_2) (Return (Atm (Int 0))))
         ((Label start)
          (Seq
            (Assign $tmp.1 (FunRef (Label even) 1))
            (Seq
              (Assign
                apply_1
                (Call (Var $tmp.1) ((Int 2))))
              (IfStmt
                (op Eq)
                (arg1 (Var apply_1))
                (arg2 (Bool true))
                (jump_then (Label block_1))
                (jump_else (Label block_2))))))))))
   (Def
     (Label even)
     ((args ((x.1 Integer)))
      (ret Boolean)
      (locals
        (($tmp.2 Integer)
         ($tmp.3 Integer)
         ($tmp.4 (Function (Integer) Boolean))
         (odd (Function (Integer) Boolean))
         (x.1 Integer)))
      (body
        (((Label block_3)
          (Return (Atm (Bool true))))
         ((Label block_4)
          (Seq
            (Assign $tmp.4 (FunRef (Label odd) 1))
            (Seq
              (Assign $tmp.2 (Prim Negate ((Int 1))))
              (Seq
                (Assign
                  $tmp.3
                  (Prim Add ((Var x.1) (Var $tmp.2))))
                (TailCall (Var $tmp.4) ((Var $tmp.3)))))))
         ((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var x.1))
            (arg2 (Int 0))
            (jump_then (Label block_3))
            (jump_else (Label block_4))))))))
   (Def
     (Label odd)
     ((args ((x.2 Integer)))
      (ret Boolean)
      (locals
        (($tmp.5 Integer)
         ($tmp.6 Integer)
         ($tmp.7 (Function (Integer) Boolean))
         (even (Function (Integer) Boolean))
         (x.2 Integer)))
      (body
        (((Label block_5)
          (Return (Atm (Bool false))))
         ((Label block_6)
          (Seq
            (Assign $tmp.7 (FunRef (Label even) 1))
            (Seq
              (Assign $tmp.5 (Prim Negate ((Int 1))))
              (Seq
                (Assign
                  $tmp.6
                  (Prim Add ((Var x.2) (Var $tmp.5))))
                (TailCall (Var $tmp.7) ((Var $tmp.6)))))))
         ((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var x.2))
            (arg2 (Int 0))
            (jump_then (Label block_5))
            (jump_else (Label block_6))))))))))
