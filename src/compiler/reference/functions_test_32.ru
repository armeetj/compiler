(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($tmp.1
           (Function (Integer Integer) Integer))
         (mult
           (Function (Integer Integer) Integer))))
      (body
        (((Label start)
          (Seq
            (Assign $tmp.1 (FunRef (Label mult) 2))
            (TailCall
              (Var $tmp.1)
              ((Int 6) (Int 7)))))))))
   (Def
     (Label mult)
     ((args ((x.1 Integer) (y.1 Integer)))
      (ret Integer)
      (locals
        (($tmp.2 Integer)
         ($tmp.3 Integer)
         ($tmp.4
           (Function (Integer Integer) Integer))
         ($tmp.5 Integer)
         (mult
           (Function (Integer Integer) Integer))
         (x.1 Integer)
         (y.1 Integer)))
      (body
        (((Label block_1) (Return (Atm (Int 0))))
         ((Label block_2)
          (Seq
            (Assign $tmp.4 (FunRef (Label mult) 2))
            (Seq
              (Assign $tmp.2 (Prim Negate ((Int 1))))
              (Seq
                (Assign
                  $tmp.3
                  (Prim Add ((Var $tmp.2) (Var x.1))))
                (Seq
                  (Assign
                    $tmp.5
                    (Call
                      (Var $tmp.4)
                      ((Var $tmp.3) (Var y.1))))
                  (Return
                    (Prim Add ((Var y.1) (Var $tmp.5)))))))))
         ((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Int 0))
            (arg2 (Var x.1))
            (jump_then (Label block_1))
            (jump_else (Label block_2))))))))))
