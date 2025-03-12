(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($tmp.1
           (Function
             (Integer)
             (Vector (Integer Integer Integer))))
         ($tmp.2 Integer)
         ($tmp.3 Integer)
         ($tmp.4 Integer)
         ($tmp.5 Integer)
         ($tmp.6 Integer)
         (tr.1
           (Vector (Integer Integer Integer)))
         (triple
           (Function
             (Integer)
             (Vector (Integer Integer Integer))))))
      (body
        (((Label start)
          (Seq
            (Assign
              $tmp.1
              (FunRef (Label triple) 1))
            (Seq
              (Assign
                tr.1
                (Call (Var $tmp.1) ((Int 13))))
              (Seq
                (Assign $tmp.2 (VecRef (Var tr.1) 0))
                (Seq
                  (Assign $tmp.3 (VecRef (Var tr.1) 1))
                  (Seq
                    (Assign $tmp.4 (VecRef (Var tr.1) 2))
                    (Seq
                      (Assign
                        $tmp.5
                        (Prim Add ((Var $tmp.4) (Int 3))))
                      (Seq
                        (Assign
                          $tmp.6
                          (Prim Add ((Var $tmp.3) (Var $tmp.5))))
                        (Return
                          (Prim Add ((Var $tmp.2) (Var $tmp.6))))))))))))))))
   (Def
     (Label triple)
     ((args ((x.1 Integer)))
      (ret (Vector (Integer Integer Integer)))
      (locals
        (($ea.1
           (Vector (Integer Integer Integer)))
         ($tmp.7 Integer)
         ($tmp.8 Integer)
         ($tmp.9 Integer)
         (_.1 Unit)
         (_.2 Unit)
         (_.3 Unit)
         (_.4 Unit)
         (x.1 Integer)))
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
                (VecSet (Var $ea.1) 0 (Var x.1)))
              (Seq
                (Assign
                  _.2
                  (VecSet (Var $ea.1) 1 (Var x.1)))
                (Seq
                  (Assign
                    _.1
                    (VecSet (Var $ea.1) 2 (Var x.1)))
                  (Return (Atm (Var $ea.1))))))))
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
            (Assign $tmp.7 (GlobalVal free_ptr))
            (Seq
              (Assign
                $tmp.8
                (Prim Add ((Var $tmp.7) (Int 32))))
              (Seq
                (Assign
                  $tmp.9
                  (GlobalVal fromspace_end))
                (IfStmt
                  (op Lt)
                  (arg1 (Var $tmp.8))
                  (arg2 (Var $tmp.9))
                  (jump_then (Label block_2))
                  (jump_else (Label block_3)))))))))))))
