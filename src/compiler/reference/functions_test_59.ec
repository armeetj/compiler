(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.4 (FunRef (Label rf) 1))
            (Seq
              (Assign
                $tmp.5
                (Call (Var $tmp.4) ((Int 0))))
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
                      (jump_else (Label block_3)))))))))
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
                (VecSet (Var $ea.1) 0 (Int 5)))
              (Seq
                (Assign
                  _.2
                  (VecSet (Var $ea.1) 1 (Int 6)))
                (Seq
                  (Assign
                    _.1
                    (VecSet (Var $ea.1) 2 (Int 7)))
                  (TailCall
                    (Var $tmp.5)
                    ((Int 42)
                     (Int 1)
                     (Int 2)
                     (Int 3)
                     (Int 4)
                     (Var $ea.1))))))))
         ((Label block_2)
          (Seq
            (Assign _.4 (Atm Void))
            (Goto (Label block_1))))
         ((Label block_3)
          (Seq
            (Collect 32)
            (Goto (Label block_1))))))))
   (Def
     (Label f)
     ((args
        ((x1.1 Integer)
         (x2.1 Integer)
         (x3.1 Integer)
         (x4.1 Integer)
         (x5.1 Integer)
         ($tup.1
           (Vector (Integer Integer Integer)))))
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Return (Atm (Var x1.1))))))))
   (Def
     (Label rf)
     ((args ((x.1 Integer)))
      (ret
        (Function
          (Integer
            Integer
            Integer
            Integer
            Integer
            (Vector (Integer Integer Integer)))
          Integer))
      (locals ())
      (body
        (((Label start)
          (Return (FunRef (Label f) 6)))))))))
