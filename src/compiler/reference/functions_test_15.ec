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
                      (jump_else (Label block_3)))))))))
         ((Label block_1)
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
            (Goto (Label block_1))))))))
   (Def
     (Label minus)
     ((args ((n.1 Integer) (m.1 Integer)))
      (ret Integer)
      (locals ())
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
      (locals ())
      (body
        (((Label start)
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
                      (jump_else (Label block_6)))))))))
         ((Label block_4)
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
            (Goto (Label block_4))))))))))
