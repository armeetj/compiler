(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($tmp.1 (Function (Integer) Integer))
         ($tmp.2 Integer)
         ($tmp.3
           (Function
             (Integer Integer Integer)
             Integer))
         ($tmp.4 Integer)
         (f (Function (Integer) Integer))
         (g
           (Function
             (Integer Integer Integer)
             Integer))))
      (body
        (((Label start)
          (Seq
            (Assign $tmp.1 (FunRef (Label f) 1))
            (Seq
              (Assign
                $tmp.2
                (Call (Var $tmp.1) ((Int 8))))
              (Seq
                (Assign $tmp.3 (FunRef (Label g) 3))
                (Seq
                  (Assign
                    $tmp.4
                    (Call
                      (Var $tmp.3)
                      ((Int 8) (Int 0) (Int 1))))
                  (Return
                    (Prim Add ((Var $tmp.2) (Var $tmp.4)))))))))))))
   (Def
     (Label f)
     ((args ((x.1 Integer)))
      (ret Integer)
      (locals
        (($tmp.10 Integer)
         ($tmp.5 Integer)
         ($tmp.6 (Function (Integer) Integer))
         ($tmp.7 Integer)
         ($tmp.8 Integer)
         ($tmp.9 (Function (Integer) Integer))
         (f (Function (Integer) Integer))
         (x.1 Integer)))
      (body
        (((Label block_1) (Return (Atm (Int 1))))
         ((Label block_2)
          (Seq
            (Assign $tmp.6 (FunRef (Label f) 1))
            (Seq
              (Assign
                $tmp.5
                (Prim Sub ((Var x.1) (Int 1))))
              (Seq
                (Assign
                  $tmp.7
                  (Call (Var $tmp.6) ((Var $tmp.5))))
                (Seq
                  (Assign $tmp.9 (FunRef (Label f) 1))
                  (Seq
                    (Assign
                      $tmp.8
                      (Prim Sub ((Var x.1) (Int 2))))
                    (Seq
                      (Assign
                        $tmp.10
                        (Call (Var $tmp.9) ((Var $tmp.8))))
                      (Return
                        (Prim Add ((Var $tmp.7) (Var $tmp.10)))))))))))
         ((Label block_3) (Return (Atm (Int 0))))
         ((Label block_4)
          (IfStmt
            (op Eq)
            (arg1 (Var x.1))
            (arg2 (Int 1))
            (jump_then (Label block_1))
            (jump_else (Label block_2))))
         ((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var x.1))
            (arg2 (Int 0))
            (jump_then (Label block_3))
            (jump_else (Label block_4))))))))
   (Def
     (Label g)
     ((args
        ((x.2 Integer)
         (y.1 Integer)
         (z.1 Integer)))
      (ret Integer)
      (locals
        (($tmp.11 Integer)
         ($tmp.12 Integer)
         ($tmp.13
           (Function
             (Integer Integer Integer)
             Integer))
         (g
           (Function
             (Integer Integer Integer)
             Integer))
         (x.2 Integer)
         (y.1 Integer)
         (z.1 Integer)))
      (body
        (((Label block_5)
          (Return (Atm (Var z.1))))
         ((Label block_6)
          (Seq
            (Assign $tmp.13 (FunRef (Label g) 3))
            (Seq
              (Assign
                $tmp.11
                (Prim Sub ((Var x.2) (Int 1))))
              (Seq
                (Assign
                  $tmp.12
                  (Prim Add ((Var y.1) (Var z.1))))
                (TailCall
                  (Var $tmp.13)
                  ((Var $tmp.11) (Var z.1) (Var $tmp.12)))))))
         ((Label block_7)
          (Return (Atm (Var y.1))))
         ((Label block_8)
          (IfStmt
            (op Eq)
            (arg1 (Var x.2))
            (arg2 (Int 1))
            (jump_then (Label block_5))
            (jump_else (Label block_6))))
         ((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var x.2))
            (arg2 (Int 0))
            (jump_then (Label block_7))
            (jump_else (Label block_8))))))))))
