(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($ea.1 (Vector (Integer)))
         ($ea.2 (Function (Integer) Integer))
         ($ea.3 (Vector (Integer)))
         ($ea.4
           (Vector
             ((Function (Integer) Integer)
              (Vector (Integer)))))
         ($tmp.1 Integer)
         ($tmp.2 Integer)
         ($tmp.3 Integer)
         ($tmp.4 Integer)
         ($tmp.5 Integer)
         ($tmp.6 Integer)
         ($tmp.7
           (Function
             (Integer
               (Vector
                 ((Function (Integer) Integer)
                  (Vector (Integer)))))
             Integer))
         (_.1 Unit)
         (_.2 Unit)
         (_.3 Unit)
         (_.4 Unit)
         (_.5 Unit)
         (f
           (Function
             (Integer
               (Vector
                 ((Function (Integer) Integer)
                  (Vector (Integer)))))
             Integer))
         (id (Function (Integer) Integer))))
      (body
        (((Label block_1)
          (Seq
            (Assign
              $ea.4
              (Allocate
                2
                (Vector
                  ((Function (Integer) Integer)
                   (Vector (Integer))))))
            (Seq
              (Assign
                _.4
                (VecSet (Var $ea.4) 0 (Var $ea.2)))
              (Seq
                (Assign
                  _.3
                  (VecSet (Var $ea.4) 1 (Var $ea.3)))
                (TailCall
                  (Var $tmp.7)
                  ((Int 0) (Var $ea.4)))))))
         ((Label block_2)
          (Seq
            (Assign _.5 (Atm Void))
            (Goto (Label block_1))))
         ((Label block_3)
          (Seq
            (Collect 24)
            (Goto (Label block_1))))
         ((Label block_4)
          (Seq
            (Assign
              $ea.1
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.1
                (VecSet (Var $ea.1) 0 (Int 42)))
              (Seq
                (Assign $ea.3 (Atm (Var $ea.1)))
                (Seq
                  (Assign $tmp.4 (GlobalVal free_ptr))
                  (Seq
                    (Assign
                      $tmp.5
                      (Prim Add ((Var $tmp.4) (Int 24))))
                    (Seq
                      (Assign
                        $tmp.6
                        (GlobalVal fromspace_end))
                      (IfStmt
                        (op Lt)
                        (arg1 (Var $tmp.5))
                        (arg2 (Var $tmp.6))
                        (jump_then (Label block_2))
                        (jump_else (Label block_3))))))))))
         ((Label block_5)
          (Seq
            (Assign _.2 (Atm Void))
            (Goto (Label block_4))))
         ((Label block_6)
          (Seq
            (Collect 16)
            (Goto (Label block_4))))
         ((Label start)
          (Seq
            (Assign $tmp.7 (FunRef (Label f) 2))
            (Seq
              (Assign $ea.2 (FunRef (Label id) 1))
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
                      (jump_then (Label block_5))
                      (jump_else (Label block_6)))))))))))))
   (Def
     (Label id)
     ((args ((x.1 Integer)))
      (ret Integer)
      (locals ((x.1 Integer)))
      (body
        (((Label start) (Return (Atm (Var x.1))))))))
   (Def
     (Label f)
     ((args
        ((n.1 Integer)
         (clos.1
           (Vector
             ((Function (Integer) Integer)
              (Vector (Integer)))))))
      (ret Integer)
      (locals
        (($ea.5 (Function (Integer) Integer))
         ($ea.6 (Vector (Integer)))
         ($ea.7
           (Vector
             ((Function (Integer) Integer)
              (Vector (Integer)))))
         ($tmp.10 (Function (Integer) Integer))
         ($tmp.11 Integer)
         ($tmp.12 Integer)
         ($tmp.13 Integer)
         ($tmp.14 Integer)
         ($tmp.15
           (Function
             (Integer
               (Vector
                 ((Function (Integer) Integer)
                  (Vector (Integer)))))
             Integer))
         ($tmp.8 (Vector (Integer)))
         ($tmp.9 Integer)
         (_.6 Unit)
         (_.7 Unit)
         (_.8 Unit)
         (clos.1
           (Vector
             ((Function (Integer) Integer)
              (Vector (Integer)))))
         (f
           (Function
             (Integer
               (Vector
                 ((Function (Integer) Integer)
                  (Vector (Integer)))))
             Integer))
         (n.1 Integer)))
      (body
        (((Label block_10)
          (Seq
            (Assign $tmp.10 (VecRef (Var clos.1) 0))
            (Seq
              (Assign $tmp.8 (VecRef (Var clos.1) 1))
              (Seq
                (Assign $tmp.9 (VecRef (Var $tmp.8) 0))
                (TailCall (Var $tmp.10) ((Var $tmp.9)))))))
         ((Label block_11)
          (Seq
            (Assign $tmp.15 (FunRef (Label f) 2))
            (Seq
              (Assign
                $tmp.11
                (Prim Add ((Var n.1) (Int 1))))
              (Seq
                (Assign $ea.5 (VecRef (Var clos.1) 0))
                (Seq
                  (Assign $ea.6 (VecRef (Var clos.1) 1))
                  (Seq
                    (Assign $tmp.12 (GlobalVal free_ptr))
                    (Seq
                      (Assign
                        $tmp.13
                        (Prim Add ((Var $tmp.12) (Int 24))))
                      (Seq
                        (Assign
                          $tmp.14
                          (GlobalVal fromspace_end))
                        (IfStmt
                          (op Lt)
                          (arg1 (Var $tmp.13))
                          (arg2 (Var $tmp.14))
                          (jump_then (Label block_8))
                          (jump_else (Label block_9)))))))))))
         ((Label block_7)
          (Seq
            (Assign
              $ea.7
              (Allocate
                2
                (Vector
                  ((Function (Integer) Integer)
                   (Vector (Integer))))))
            (Seq
              (Assign
                _.7
                (VecSet (Var $ea.7) 0 (Var $ea.5)))
              (Seq
                (Assign
                  _.6
                  (VecSet (Var $ea.7) 1 (Var $ea.6)))
                (TailCall
                  (Var $tmp.15)
                  ((Var $tmp.11) (Var $ea.7)))))))
         ((Label block_8)
          (Seq
            (Assign _.8 (Atm Void))
            (Goto (Label block_7))))
         ((Label block_9)
          (Seq
            (Collect 24)
            (Goto (Label block_7))))
         ((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var n.1))
            (arg2 (Int 100))
            (jump_then (Label block_10))
            (jump_else (Label block_11))))))))))
