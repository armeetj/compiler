(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.2 (FunRef (Label g) 1))
            (Seq
              (Assign
                $tmp.1
                (FunRef (Label sum_eight) 6))
              (Seq
                (Assign
                  $tmp.3
                  (Call (Var $tmp.2) ((Var $tmp.1))))
                (Return
                  (Prim Add ((Int 6) (Var $tmp.3))))))))))))
   (Def
     (Label sum_eight)
     ((args
        ((a.1 Integer)
         (b.1 Integer)
         (c.1 Integer)
         (d.1 Integer)
         (e.1 Integer)
         ($tup.1
           (Vector (Integer Integer Integer)))))
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign
              $tmp.4
              (Prim Add ((Var a.1) (Var b.1))))
            (Seq
              (Assign
                $tmp.5
                (Prim Add ((Var c.1) (Var d.1))))
              (Seq
                (Assign
                  $tmp.6
                  (Prim Add ((Var $tmp.4) (Var $tmp.5))))
                (Seq
                  (Assign $tmp.7 (VecRef (Var $tup.1) 0))
                  (Seq
                    (Assign
                      $tmp.8
                      (Prim Add ((Var e.1) (Var $tmp.7))))
                    (Seq
                      (Assign $tmp.9 (VecRef (Var $tup.1) 1))
                      (Seq
                        (Assign $tmp.10 (VecRef (Var $tup.1) 2))
                        (Seq
                          (Assign
                            $tmp.11
                            (Prim Add ((Var $tmp.9) (Var $tmp.10))))
                          (Seq
                            (Assign
                              $tmp.12
                              (Prim Add ((Var $tmp.8) (Var $tmp.11))))
                            (Return
                              (Prim Add ((Var $tmp.6) (Var $tmp.12))))))))))))))))))
   (Def
     (Label g)
     ((args
        ((f.2
           (Function
             (Integer
               Integer
               Integer
               Integer
               Integer
               (Vector (Integer Integer Integer)))
             Integer))))
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.13 (GlobalVal free_ptr))
            (Seq
              (Assign
                $tmp.14
                (Prim Add ((Var $tmp.13) (Int 32))))
              (Seq
                (Assign
                  $tmp.15
                  (GlobalVal fromspace_end))
                (IfStmt
                  (op Lt)
                  (arg1 (Var $tmp.14))
                  (arg2 (Var $tmp.15))
                  (jump_then (Label block_2))
                  (jump_else (Label block_3)))))))
         ((Label block_1)
          (Seq
            (Assign
              $ea.1
              (Allocate
                3
                (Vector (Integer Integer Integer))))
            (Seq
              (Assign
                _.3
                (VecSet (Var $ea.1) 0 (Int 6)))
              (Seq
                (Assign
                  _.2
                  (VecSet (Var $ea.1) 1 (Int 7)))
                (Seq
                  (Assign
                    _.1
                    (VecSet (Var $ea.1) 2 (Int 8)))
                  (TailCall
                    (Var f.2)
                    ((Int 1)
                     (Int 2)
                     (Int 3)
                     (Int 4)
                     (Int 5)
                     (Var $ea.1))))))))
         ((Label block_2)
          (Seq
            (Assign _.4 (Atm Void))
            (Goto (Label block_1))))
         ((Label block_3)
          (Seq
            (Collect 32)
            (Goto (Label block_1))))))))))
