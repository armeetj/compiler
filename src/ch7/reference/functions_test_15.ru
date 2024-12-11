(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($ea.1 (Vector (Integer)))
         ($tmp.1
           (Function (Integer Integer) Integer))
         ($tmp.2 Integer)
         ($tmp.3 Integer)
         ($tmp.4 Integer)
         ($tmp.5
           (Function
             ((Function (Integer Integer) Integer)
              (Vector (Integer)))
             (Vector (Integer))))
         ($tmp.6 (Vector (Integer)))
         (_.1 Unit)
         (_.2 Unit)
         (map_vector
           (Function
             ((Function (Integer Integer) Integer)
              (Vector (Integer)))
             (Vector (Integer))))
         (minus
           (Function (Integer Integer) Integer))))
      (body
        (((Label block_1)
          (Seq
            (Assign
              $ea.1
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.1
                (VecSet (Var $ea.1) 0 (Int 43)))
              (Seq
                (Assign
                  $tmp.6
                  (Call
                    (Var $tmp.5)
                    ((Var $tmp.1) (Var $ea.1))))
                (Return (VecRef (Var $tmp.6) 0))))))
         ((Label block_2)
          (Seq
            (Assign _.2 (Atm Void))
            (Goto (Label block_1))))
         ((Label block_3)
          (Seq
            (Collect 16)
            (Goto (Label block_1))))
         ((Label start)
          (Seq
            (Assign
              $tmp.5
              (FunRef (Label map_vector) 2))
            (Seq
              (Assign $tmp.1 (FunRef (Label minus) 2))
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
                      (jump_else (Label block_3)))))))))))))
   (Def
     (Label minus)
     ((args ((n.1 Integer) (m.1 Integer)))
      (ret Integer)
      (locals
        (($tmp.7 Integer)
         (m.1 Integer)
         (n.1 Integer)))
      (body
        (((Label start)
          (Seq
            (Assign
              $tmp.7
              (Prim Negate ((Var m.1))))
            (Return
              (Prim Add ((Var n.1) (Var $tmp.7))))))))))
   (Def
     (Label map_vector)
     ((args
        ((f.1
           (Function (Integer Integer) Integer))
         (v.1 (Vector (Integer)))))
      (ret (Vector (Integer)))
      (locals
        (($ea.2 Integer)
         ($ea.3 (Vector (Integer)))
         ($tmp.10 Integer)
         ($tmp.11 Integer)
         ($tmp.8 Integer)
         ($tmp.9 Integer)
         (_.3 Unit)
         (_.4 Unit)
         (f.1
           (Function (Integer Integer) Integer))
         (v.1 (Vector (Integer)))))
      (body
        (((Label block_4)
          (Seq
            (Assign
              $ea.3
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.3
                (VecSet (Var $ea.3) 0 (Var $ea.2)))
              (Return (Atm (Var $ea.3))))))
         ((Label block_5)
          (Seq
            (Assign _.4 (Atm Void))
            (Goto (Label block_4))))
         ((Label block_6)
          (Seq
            (Collect 16)
            (Goto (Label block_4))))
         ((Label start)
          (Seq
            (Assign $tmp.8 (VecRef (Var v.1) 0))
            (Seq
              (Assign
                $ea.2
                (Call (Var f.1) ((Var $tmp.8) (Int 1))))
              (Seq
                (Assign $tmp.9 (GlobalVal free_ptr))
                (Seq
                  (Assign
                    $tmp.10
                    (Prim Add ((Var $tmp.9) (Int 16))))
                  (Seq
                    (Assign
                      $tmp.11
                      (GlobalVal fromspace_end))
                    (IfStmt
                      (op Lt)
                      (arg1 (Var $tmp.10))
                      (arg2 (Var $tmp.11))
                      (jump_then (Label block_5))
                      (jump_else (Label block_6)))))))))))))))
