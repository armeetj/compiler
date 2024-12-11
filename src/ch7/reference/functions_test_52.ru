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
         ($tmp.4 Integer)
         ($tmp.5 (Function (Integer) Integer))
         ($tmp.6 Integer)
         ($tmp.7 Integer)
         (_.1 Unit)
         (_.2 Unit)
         (add1 (Function (Integer) Integer))
         (v.1 (Vector (Integer)))))
      (body
        (((Label block_1)
          (Seq
            (Assign
              $ea.1
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.1
                (VecSet (Var $ea.1) 0 (Int 41)))
              (Seq
                (Assign v.1 (Atm (Var $ea.1)))
                (Seq
                  (Assign $tmp.5 (FunRef (Label add1) 1))
                  (Seq
                    (Assign $tmp.4 (Prim Read ()))
                    (Seq
                      (Assign
                        $tmp.6
                        (Call (Var $tmp.5) ((Var $tmp.4))))
                      (Seq
                        (Assign $tmp.7 (VecRef (Var v.1) 0))
                        (Return
                          (Prim Add ((Var $tmp.6) (Var $tmp.7))))))))))))
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
                  (jump_else (Label block_3)))))))))))
   (Def
     (Label add1)
     ((args ((x.1 Integer)))
      (ret Integer)
      (locals ((x.1 Integer)))
      (body
        (((Label start)
          (Return (Prim Add ((Var x.1) (Int 1)))))))))))
