(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.4 (FunRef (Label h) 6))
            (Seq
              (Assign $tmp.1 (GlobalVal free_ptr))
              (Seq
                (Assign
                  $tmp.2
                  (Prim Add ((Var $tmp.1) (Int 24))))
                (Seq
                  (Assign
                    $tmp.3
                    (GlobalVal fromspace_end))
                  (IfStmt
                    (op Lt)
                    (arg1 (Var $tmp.2))
                    (arg2 (Var $tmp.3))
                    (jump_then (Label block_2))
                    (jump_else (Label block_3))))))))
         ((Label block_1)
          (Seq
            (Assign
              $ea.1
              (Allocate 2 (Vector (Integer Integer))))
            (Seq
              (Assign
                _.2
                (VecSet (Var $ea.1) 0 (Int 1)))
              (Seq
                (Assign
                  _.1
                  (VecSet (Var $ea.1) 1 (Int 0)))
                (TailCall
                  (Var $tmp.4)
                  ((Int 0)
                   (Int 0)
                   (Int 0)
                   (Int 0)
                   (Int 0)
                   (Var $ea.1)))))))
         ((Label block_2)
          (Seq
            (Assign _.3 (Atm Void))
            (Goto (Label block_1))))
         ((Label block_3)
          (Seq
            (Collect 24)
            (Goto (Label block_1))))))))
   (Def
     (Label h)
     ((args
        ((a.1 Integer)
         (b.1 Integer)
         (c.1 Integer)
         (d.1 Integer)
         (e.1 Integer)
         ($tup.1 (Vector (Integer Integer)))))
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.5 (VecRef (Var $tup.1) 0))
            (Seq
              (Assign $tmp.6 (VecRef (Var $tup.1) 1))
              (Seq
                (Assign
                  $tmp.7
                  (Prim Add ((Var $tmp.5) (Var $tmp.6))))
                (Seq
                  (Assign
                    $tmp.8
                    (Prim Add ((Var e.1) (Var $tmp.7))))
                  (Seq
                    (Assign
                      $tmp.9
                      (Prim Add ((Var d.1) (Var $tmp.8))))
                    (Seq
                      (Assign
                        $tmp.10
                        (Prim Add ((Var c.1) (Var $tmp.9))))
                      (Seq
                        (Assign
                          $tmp.11
                          (Prim Add ((Var b.1) (Var $tmp.10))))
                        (Return
                          (Prim Add ((Var a.1) (Var $tmp.11))))))))))))))))))
