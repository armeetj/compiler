(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($tmp.1 Integer)
         ($tmp.2 Integer)
         ($tmp.3
           (Function (Integer Integer) Integer))
         ($tmp.4 Integer)
         (ack
           (Function (Integer Integer) Integer))))
      (body
        (((Label start)
          (Seq
            (Assign $tmp.3 (FunRef (Label ack) 2))
            (Seq
              (Assign $tmp.1 (Prim Read ()))
              (Seq
                (Assign $tmp.2 (Prim Read ()))
                (Seq
                  (Assign
                    $tmp.4
                    (Call
                      (Var $tmp.3)
                      ((Var $tmp.1) (Var $tmp.2))))
                  (Return
                    (Prim Add ((Var $tmp.4) (Int 41)))))))))))))
   (Def
     (Label ack)
     ((args ((m.1 Integer) (n.1 Integer)))
      (ret Integer)
      (locals
        (($tmp.10 Integer)
         ($tmp.11
           (Function (Integer Integer) Integer))
         ($tmp.5 Integer)
         ($tmp.6
           (Function (Integer Integer) Integer))
         ($tmp.7 Integer)
         ($tmp.8 Integer)
         ($tmp.9
           (Function (Integer Integer) Integer))
         (ack
           (Function (Integer Integer) Integer))
         (m.1 Integer)
         (n.1 Integer)))
      (body
        (((Label block_1)
          (Seq
            (Assign $tmp.6 (FunRef (Label ack) 2))
            (Seq
              (Assign
                $tmp.5
                (Prim Sub ((Var m.1) (Int 1))))
              (TailCall
                (Var $tmp.6)
                ((Var $tmp.5) (Int 1))))))
         ((Label block_2)
          (Seq
            (Assign $tmp.11 (FunRef (Label ack) 2))
            (Seq
              (Assign
                $tmp.7
                (Prim Sub ((Var m.1) (Int 1))))
              (Seq
                (Assign $tmp.9 (FunRef (Label ack) 2))
                (Seq
                  (Assign
                    $tmp.8
                    (Prim Sub ((Var n.1) (Int 1))))
                  (Seq
                    (Assign
                      $tmp.10
                      (Call
                        (Var $tmp.9)
                        ((Var m.1) (Var $tmp.8))))
                    (TailCall
                      (Var $tmp.11)
                      ((Var $tmp.7) (Var $tmp.10)))))))))
         ((Label block_3)
          (Return (Prim Add ((Int 1) (Var n.1)))))
         ((Label block_4)
          (IfStmt
            (op Eq)
            (arg1 (Var n.1))
            (arg2 (Int 0))
            (jump_then (Label block_1))
            (jump_else (Label block_2))))
         ((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var m.1))
            (arg2 (Int 0))
            (jump_then (Label block_3))
            (jump_else (Label block_4))))))))))