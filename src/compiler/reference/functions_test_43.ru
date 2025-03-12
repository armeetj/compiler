(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($ea.1
           (Vector
             (Integer
               Integer
               Integer
               Integer
               Integer)))
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
               (Vector
                 (Integer
                   Integer
                   Integer
                   Integer
                   Integer)))
             Integer))
         (_.1 Unit)
         (_.2 Unit)
         (_.3 Unit)
         (_.4 Unit)
         (_.5 Unit)
         (_.6 Unit)
         (big
           (Function
             (Integer
               Integer
               Integer
               Integer
               Integer
               (Vector
                 (Integer
                   Integer
                   Integer
                   Integer
                   Integer)))
             Integer))))
      (body
        (((Label block_1)
          (Seq
            (Assign
              $ea.1
              (Allocate
                5
                (Vector
                  (Integer
                    Integer
                    Integer
                    Integer
                    Integer))))
            (Seq
              (Assign
                _.5
                (VecSet (Var $ea.1) 0 (Int 6)))
              (Seq
                (Assign
                  _.4
                  (VecSet (Var $ea.1) 1 (Int 7)))
                (Seq
                  (Assign
                    _.3
                    (VecSet (Var $ea.1) 2 (Int 8)))
                  (Seq
                    (Assign
                      _.2
                      (VecSet (Var $ea.1) 3 (Int 9)))
                    (Seq
                      (Assign
                        _.1
                        (VecSet (Var $ea.1) 4 (Int 22)))
                      (TailCall
                        (Var $tmp.4)
                        ((Int 1)
                         (Int 2)
                         (Int 3)
                         (Int 20)
                         (Int 5)
                         (Var $ea.1))))))))))
         ((Label block_2)
          (Seq
            (Assign _.6 (Atm Void))
            (Goto (Label block_1))))
         ((Label block_3)
          (Seq
            (Collect 48)
            (Goto (Label block_1))))
         ((Label start)
          (Seq
            (Assign $tmp.4 (FunRef (Label big) 6))
            (Seq
              (Assign $tmp.1 (GlobalVal free_ptr))
              (Seq
                (Assign
                  $tmp.2
                  (Prim Add ((Var $tmp.1) (Int 48))))
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
     (Label big)
     ((args
        ((a.1 Integer)
         (b.1 Integer)
         (c.1 Integer)
         (d.1 Integer)
         (e.1 Integer)
         ($tup.1
           (Vector
             (Integer
               Integer
               Integer
               Integer
               Integer)))))
      (ret Integer)
      (locals
        (($tmp.5 Integer)
         ($tup.1
           (Vector
             (Integer
               Integer
               Integer
               Integer
               Integer)))
         (d.1 Integer)))
      (body
        (((Label start)
          (Seq
            (Assign $tmp.5 (VecRef (Var $tup.1) 4))
            (Return
              (Prim Add ((Var d.1) (Var $tmp.5))))))))))))
