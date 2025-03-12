(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.2 (FunRef (Label even?) 1))
            (Seq
              (Assign $tmp.1 (Prim Read ()))
              (Seq
                (Assign
                  apply_1
                  (Call (Var $tmp.2) ((Var $tmp.1))))
                (IfStmt
                  (op Eq)
                  (arg1 (Var apply_1))
                  (arg2 (Bool true))
                  (jump_then (Label block_1))
                  (jump_else (Label block_2)))))))
         ((Label block_1)
          (Return (Atm (Int 999))))
         ((Label block_2)
          (Return (Atm (Int 42))))))))
   (Def
     (Label even?)
     ((args ((x.1 Integer)))
      (ret Boolean)
      (locals ())
      (body
        (((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var x.1))
            (arg2 (Int 0))
            (jump_then (Label block_3))
            (jump_else (Label block_4))))
         ((Label block_3)
          (Return (Atm (Bool true))))
         ((Label block_4)
          (Seq
            (Assign $tmp.5 (FunRef (Label odd?) 1))
            (Seq
              (Assign $tmp.3 (Prim Negate ((Int 1))))
              (Seq
                (Assign
                  $tmp.4
                  (Prim Add ((Var $tmp.3) (Var x.1))))
                (TailCall (Var $tmp.5) ((Var $tmp.4)))))))))))
   (Def
     (Label odd?)
     ((args ((x.2 Integer)))
      (ret Boolean)
      (locals ())
      (body
        (((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var x.2))
            (arg2 (Int 0))
            (jump_then (Label block_5))
            (jump_else (Label block_6))))
         ((Label block_5)
          (Return (Atm (Bool false))))
         ((Label block_6)
          (Seq
            (Assign $tmp.8 (FunRef (Label even?) 1))
            (Seq
              (Assign $tmp.6 (Prim Negate ((Int 1))))
              (Seq
                (Assign
                  $tmp.7
                  (Prim Add ((Var $tmp.6) (Var x.2))))
                (TailCall (Var $tmp.8) ((Var $tmp.7)))))))))))))
