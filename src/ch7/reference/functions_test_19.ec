(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.4 (FunRef (Label m) 6))
            (Seq
              (Assign $tmp.1 (GlobalVal free_ptr))
              (Seq
                (Assign
                  $tmp.2
                  (Prim Add ((Var $tmp.1) (Int 40))))
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
              (Allocate
                4
                (Vector
                  (Integer Integer Integer Integer))))
            (Seq
              (Assign
                _.4
                (VecSet (Var $ea.1) 0 (Int 772)))
              (Seq
                (Assign
                  _.3
                  (VecSet (Var $ea.1) 1 (Int 771)))
                (Seq
                  (Assign
                    _.2
                    (VecSet (Var $ea.1) 2 (Int 770)))
                  (Seq
                    (Assign
                      _.1
                      (VecSet (Var $ea.1) 3 (Int 42)))
                    (TailCall
                      (Var $tmp.4)
                      ((Int 777)
                       (Int 776)
                       (Int 775)
                       (Int 774)
                       (Int 773)
                       (Var $ea.1)))))))))
         ((Label block_2)
          (Seq
            (Assign _.5 (Atm Void))
            (Goto (Label block_1))))
         ((Label block_3)
          (Seq
            (Collect 40)
            (Goto (Label block_1))))))))
   (Def
     (Label m)
     ((args
        ((a.1 Integer)
         (b.1 Integer)
         (c.1 Integer)
         (d.1 Integer)
         (e.1 Integer)
         ($tup.1
           (Vector
             (Integer Integer Integer Integer)))))
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Return (VecRef (Var $tup.1) 3)))))))))