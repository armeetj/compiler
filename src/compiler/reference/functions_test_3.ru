(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($ea.1
           (Vector (Integer Integer Integer)))
         ($tmp.1 Integer)
         ($tmp.2 Integer)
         ($tmp.3 Integer)
         ($tmp.4
           (Function
             (Integer
               Integer
               Integer
               Integer
               Integer
               (Vector (Integer Integer Integer)))
             Integer))
         (_.1 Unit)
         (_.2 Unit)
         (_.3 Unit)
         (_.4 Unit)
         (fun
           (Function
             (Integer
               Integer
               Integer
               Integer
               Integer
               (Vector (Integer Integer Integer)))
             Integer))))
      (body
        (((Label block_1)
          (Seq
            (Assign
              $ea.1
              (Allocate
                3
                (Vector (Integer Integer Integer))))
            (Seq
              (Assign
                _.3
                (VecSet (Var $ea.1) 0 (Int 5)))
              (Seq
                (Assign
                  _.2
                  (VecSet (Var $ea.1) 1 (Int 5)))
                (Seq
                  (Assign
                    _.1
                    (VecSet (Var $ea.1) 2 (Int 7)))
                  (TailCall
                    (Var $tmp.4)
                    ((Int 5)
                     (Int 5)
                     (Int 5)
                     (Int 5)
                     (Int 5)
                     (Var $ea.1))))))))
         ((Label block_2)
          (Seq
            (Assign _.4 (Atm Void))
            (Goto (Label block_1))))
         ((Label block_3)
          (Seq
            (Collect 32)
            (Goto (Label block_1))))
         ((Label start)
          (Seq
            (Assign $tmp.4 (FunRef (Label fun) 6))
            (Seq
              (Assign $tmp.1 (GlobalVal free_ptr))
              (Seq
                (Assign
                  $tmp.2
                  (Prim Add ((Var $tmp.1) (Int 32))))
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
     (Label fun)
     ((args
        ((x1.1 Integer)
         (x2.1 Integer)
         (x3.1 Integer)
         (x4.1 Integer)
         (x5.1 Integer)
         ($tup.1
           (Vector (Integer Integer Integer)))))
      (ret Integer)
      (locals
        (($tmp.10 Integer)
         ($tmp.11 Integer)
         ($tmp.12 Integer)
         ($tmp.13 Integer)
         ($tmp.5 Integer)
         ($tmp.6 Integer)
         ($tmp.7 Integer)
         ($tmp.8 Integer)
         ($tmp.9 Integer)
         ($tup.1
           (Vector (Integer Integer Integer)))
         (x1.1 Integer)
         (x2.1 Integer)
         (x3.1 Integer)
         (x4.1 Integer)
         (x5.1 Integer)))
      (body
        (((Label start)
          (Seq
            (Assign $tmp.5 (VecRef (Var $tup.1) 0))
            (Seq
              (Assign $tmp.6 (VecRef (Var $tup.1) 1))
              (Seq
                (Assign $tmp.7 (VecRef (Var $tup.1) 2))
                (Seq
                  (Assign
                    $tmp.8
                    (Prim Add ((Var $tmp.6) (Var $tmp.7))))
                  (Seq
                    (Assign
                      $tmp.9
                      (Prim Add ((Var $tmp.5) (Var $tmp.8))))
                    (Seq
                      (Assign
                        $tmp.10
                        (Prim Add ((Var x5.1) (Var $tmp.9))))
                      (Seq
                        (Assign
                          $tmp.11
                          (Prim Add ((Var x4.1) (Var $tmp.10))))
                        (Seq
                          (Assign
                            $tmp.12
                            (Prim Add ((Var x3.1) (Var $tmp.11))))
                          (Seq
                            (Assign
                              $tmp.13
                              (Prim Add ((Var x2.1) (Var $tmp.12))))
                            (Return
                              (Prim Add ((Var x1.1) (Var $tmp.13))))))))))))))))))))
