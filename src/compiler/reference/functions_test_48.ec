(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.1 (FunRef (Label f) 2))
            (TailCall
              (Var $tmp.1)
              ((Int 11) (Int 10)))))))))
   (Def
     (Label add)
     ((args ((x.1 Integer) (y.1 Integer)))
      (ret (Vector (Integer)))
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign
              $ea.1
              (Prim Add ((Var x.1) (Var y.1))))
            (Seq
              (Assign $tmp.2 (GlobalVal free_ptr))
              (Seq
                (Assign
                  $tmp.3
                  (Prim Add ((Var $tmp.2) (Int 16))))
                (Seq
                  (Assign
                    $tmp.4
                    (GlobalVal fromspace_end))
                  (IfStmt
                    (op Lt)
                    (arg1 (Var $tmp.3))
                    (arg2 (Var $tmp.4))
                    (jump_then (Label block_2))
                    (jump_else (Label block_3))))))))
         ((Label block_1)
          (Seq
            (Assign
              $ea.2
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.1
                (VecSet (Var $ea.2) 0 (Var $ea.1)))
              (Return (Atm (Var $ea.2))))))
         ((Label block_2)
          (Seq
            (Assign _.2 (Atm Void))
            (Goto (Label block_1))))
         ((Label block_3)
          (Seq
            (Collect 16)
            (Goto (Label block_1))))))))
   (Def
     (Label f)
     ((args ((x.2 Integer) (y.2 Integer)))
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.5 (GlobalVal free_ptr))
            (Seq
              (Assign
                $tmp.6
                (Prim Add ((Var $tmp.5) (Int 24))))
              (Seq
                (Assign
                  $tmp.7
                  (GlobalVal fromspace_end))
                (IfStmt
                  (op Lt)
                  (arg1 (Var $tmp.6))
                  (arg2 (Var $tmp.7))
                  (jump_then (Label block_5))
                  (jump_else (Label block_6)))))))
         ((Label block_4)
          (Seq
            (Assign
              $ea.3
              (Allocate 2 (Vector (Integer Integer))))
            (Seq
              (Assign
                _.4
                (VecSet (Var $ea.3) 0 (Var x.2)))
              (Seq
                (Assign
                  _.3
                  (VecSet (Var $ea.3) 1 (Var y.2)))
                (Seq
                  (Assign v.1 (Atm (Var $ea.3)))
                  (Seq
                    (Assign $tmp.8 (FunRef (Label add) 2))
                    (Seq
                      (Assign
                        z.1
                        (Call
                          (Var $tmp.8)
                          ((Var x.2) (Var y.2))))
                      (Seq
                        (Assign $tmp.9 (VecRef (Var v.1) 0))
                        (Seq
                          (Assign $tmp.10 (VecRef (Var v.1) 1))
                          (Seq
                            (Assign
                              $tmp.11
                              (Prim Add ((Var $tmp.9) (Var $tmp.10))))
                            (Seq
                              (Assign $tmp.12 (VecRef (Var z.1) 0))
                              (Return
                                (Prim Add ((Var $tmp.11) (Var $tmp.12)))))))))))))))
         ((Label block_5)
          (Seq
            (Assign _.5 (Atm Void))
            (Goto (Label block_4))))
         ((Label block_6)
          (Seq
            (Collect 24)
            (Goto (Label block_4))))))))))
