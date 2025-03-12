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
              $tmp.5
              (FunRef (Label map_vec) 2))
            (Seq
              (Assign $tmp.1 (FunRef (Label add1) 1))
              (Seq
                (Assign $tmp.2 (GlobalVal free_ptr))
                (Seq
                  (Assign
                    $tmp.3
                    (Prim Add ((Var $tmp.2) (Int 24))))
                  (Seq
                    (Assign
                      $tmp.4
                      (GlobalVal fromspace_end))
                    (IfStmt
                      (op Lt)
                      (arg1 (Var $tmp.3))
                      (arg2 (Var $tmp.4))
                      (jump_then (Label block_2))
                      (jump_else (Label block_3)))))))))
         ((Label block_1)
          (Seq
            (Assign
              $ea.1
              (Allocate 2 (Vector (Integer Integer))))
            (Seq
              (Assign
                _.2
                (VecSet (Var $ea.1) 0 (Int 0)))
              (Seq
                (Assign
                  _.1
                  (VecSet (Var $ea.1) 1 (Int 41)))
                (Seq
                  (Assign
                    $tmp.6
                    (Call
                      (Var $tmp.5)
                      ((Var $tmp.1) (Var $ea.1))))
                  (Return (VecRef (Var $tmp.6) 1)))))))
         ((Label block_2)
          (Seq
            (Assign _.3 (Atm Void))
            (Goto (Label block_1))))
         ((Label block_3)
          (Seq
            (Collect 24)
            (Goto (Label block_1))))))))
   (Def
     (Label map_vec)
     ((args
        ((f.1 (Function (Integer) Integer))
         (v.1 (Vector (Integer Integer)))))
      (ret (Vector (Integer Integer)))
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.7 (VecRef (Var v.1) 0))
            (Seq
              (Assign
                $ea.2
                (Call (Var f.1) ((Var $tmp.7))))
              (Seq
                (Assign $tmp.8 (VecRef (Var v.1) 1))
                (Seq
                  (Assign
                    $ea.3
                    (Call (Var f.1) ((Var $tmp.8))))
                  (Seq
                    (Assign $tmp.9 (GlobalVal free_ptr))
                    (Seq
                      (Assign
                        $tmp.10
                        (Prim Add ((Var $tmp.9) (Int 24))))
                      (Seq
                        (Assign
                          $tmp.11
                          (GlobalVal fromspace_end))
                        (IfStmt
                          (op Lt)
                          (arg1 (Var $tmp.10))
                          (arg2 (Var $tmp.11))
                          (jump_then (Label block_5))
                          (jump_else (Label block_6)))))))))))
         ((Label block_4)
          (Seq
            (Assign
              $ea.4
              (Allocate 2 (Vector (Integer Integer))))
            (Seq
              (Assign
                _.5
                (VecSet (Var $ea.4) 0 (Var $ea.2)))
              (Seq
                (Assign
                  _.4
                  (VecSet (Var $ea.4) 1 (Var $ea.3)))
                (Return (Atm (Var $ea.4)))))))
         ((Label block_5)
          (Seq
            (Assign _.6 (Atm Void))
            (Goto (Label block_4))))
         ((Label block_6)
          (Seq
            (Collect 24)
            (Goto (Label block_4))))))))
   (Def
     (Label add1)
     ((args ((x.1 Integer)))
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Return (Prim Add ((Var x.1) (Int 1)))))))))))
