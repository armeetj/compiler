(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($ea.1 (Vector (Integer)))
         ($tmp.1 Integer)
         ($tmp.2 Integer)
         ($tmp.3 Integer)
         ($tmp.4
           (Function ((Vector (Integer))) Integer))
         (_.1 Unit)
         (_.2 Unit)
         (f
           (Function ((Vector (Integer))) Integer))))
      (body
        (((Label block_1)
          (Seq
            (Assign
              $ea.1
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.1
                (VecSet (Var $ea.1) 0 (Int 42)))
              (TailCall (Var $tmp.4) ((Var $ea.1))))))
         ((Label block_2)
          (Seq
            (Assign _.2 (Atm Void))
            (Goto (Label block_1))))
         ((Label block_3)
          (Seq
            (Collect 16)
            (Goto (Label block_1))))
         ((Label start)
          (Seq
            (Assign $tmp.4 (FunRef (Label f) 1))
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
                    (jump_else (Label block_3))))))))))))
   (Def
     (Label f)
     ((args ((v.1 (Vector (Integer)))))
      (ret Integer)
      (locals ((v.1 (Vector (Integer)))))
      (body
        (((Label start)
          (Return (VecRef (Var v.1) 0)))))))))
