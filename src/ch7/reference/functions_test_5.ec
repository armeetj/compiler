(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign
              $tmp.1
              (FunRef (Label tailrecur) 1))
            (Seq
              (Assign
                $tmp.2
                (Call (Var $tmp.1) ((Int 99))))
              (IfStmt
                (op Eq)
                (arg1 (Int 0))
                (arg2 (Var $tmp.2))
                (jump_then (Label block_1))
                (jump_else (Label block_2))))))
         ((Label block_1)
          (Return (Atm (Int 42))))
         ((Label block_2)
          (Return (Atm (Int 777))))))))
   (Def
     (Label tailrecur)
     ((args ((x.1 Integer)))
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var x.1))
            (arg2 (Int 0))
            (jump_then (Label block_3))
            (jump_else (Label block_4))))
         ((Label block_3) (Return (Atm (Int 0))))
         ((Label block_4)
          (Seq
            (Assign
              $tmp.5
              (FunRef (Label tailrecur) 1))
            (Seq
              (Assign $tmp.3 (Prim Negate ((Int 1))))
              (Seq
                (Assign
                  $tmp.4
                  (Prim Add ((Var x.1) (Var $tmp.3))))
                (TailCall (Var $tmp.5) ((Var $tmp.4)))))))))))))
