(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($tmp.1
           (Function (Integer Integer) Integer))
         ($tmp.2 Integer)
         (tail_sum
           (Function (Integer Integer) Integer))))
      (body
        (((Label start)
          (Seq
            (Assign
              $tmp.1
              (FunRef (Label tail_sum) 2))
            (Seq
              (Assign
                $tmp.2
                (Call (Var $tmp.1) ((Int 5) (Int 0))))
              (Return
                (Prim Add ((Var $tmp.2) (Int 27)))))))))))
   (Def
     (Label tail_sum)
     ((args ((n.1 Integer) (r.1 Integer)))
      (ret Integer)
      (locals
        (($tmp.3 Integer)
         ($tmp.4 Integer)
         ($tmp.5
           (Function (Integer Integer) Integer))
         (n.1 Integer)
         (r.1 Integer)
         (tail_sum
           (Function (Integer Integer) Integer))))
      (body
        (((Label block_1)
          (Return (Atm (Var r.1))))
         ((Label block_2)
          (Seq
            (Assign
              $tmp.5
              (FunRef (Label tail_sum) 2))
            (Seq
              (Assign
                $tmp.3
                (Prim Sub ((Var n.1) (Int 1))))
              (Seq
                (Assign
                  $tmp.4
                  (Prim Add ((Var n.1) (Var r.1))))
                (TailCall
                  (Var $tmp.5)
                  ((Var $tmp.3) (Var $tmp.4)))))))
         ((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var n.1))
            (arg2 (Int 0))
            (jump_then (Label block_1))
            (jump_else (Label block_2))))))))))
