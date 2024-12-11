(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.4 (FunRef (Label f) 1))
            (Seq
              (Assign $ea.1 (FunRef (Label id) 1))
              (Seq
                (Assign $tmp.1 (GlobalVal free_ptr))
                (Seq
                  (Assign
                    $tmp.2
                    (Prim Add ((Var $tmp.1) (Int 16))))
                  (Seq
                    (Assign
                      $tmp.3
                      (GlobalVal fromspace_end))
                    (IfStmt
                      (op Lt)
                      (arg1 (Var $tmp.2))
                      (arg2 (Var $tmp.3))
                      (jump_then (Label block_2))
                      (jump_else (Label block_3)))))))))
         ((Label block_1)
          (Seq
            (Assign
              $ea.2
              (Allocate
                1
                (Vector ((Function (Integer) Integer)))))
            (Seq
              (Assign
                _.1
                (VecSet (Var $ea.2) 0 (Var $ea.1)))
              (Seq
                (Assign
                  $tmp.5
                  (Call (Var $tmp.4) ((Var $ea.2))))
                (TailCall (Var $tmp.5) ((Int 42)))))))
         ((Label block_2)
          (Seq
            (Assign _.2 (Atm Void))
            (Goto (Label block_1))))
         ((Label block_3)
          (Seq
            (Collect 16)
            (Goto (Label block_1))))))))
   (Def
     (Label id)
     ((args ((x.1 Integer)))
      (ret Integer)
      (locals ())
      (body
        (((Label start) (Return (Atm (Var x.1))))))))
   (Def
     (Label f)
     ((args
        ((v.1
           (Vector ((Function (Integer) Integer))))))
      (ret (Function (Integer) Integer))
      (locals ())
      (body
        (((Label start)
          (Return (VecRef (Var v.1) 0)))))))))
