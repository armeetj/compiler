(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($ea.1 (Vector (Integer)))
         ($ea.10 (Vector (Integer)))
         ($ea.2 (Vector (Integer)))
         ($ea.3 (Vector (Integer)))
         ($ea.4 (Vector (Integer)))
         ($ea.5 (Vector (Integer)))
         ($ea.6 (Vector (Integer)))
         ($ea.7 (Vector (Integer)))
         ($ea.8 (Vector (Integer)))
         ($ea.9 (Vector (Integer)))
         ($tmp.1 Integer)
         ($tmp.10 Integer)
         ($tmp.11 Integer)
         ($tmp.12 Integer)
         ($tmp.13 Integer)
         ($tmp.14 Integer)
         ($tmp.15 Integer)
         ($tmp.16 Integer)
         ($tmp.17 Integer)
         ($tmp.18 Integer)
         ($tmp.19 Integer)
         ($tmp.2 Integer)
         ($tmp.20 Integer)
         ($tmp.21 Integer)
         ($tmp.22 Integer)
         ($tmp.23 Integer)
         ($tmp.24 Integer)
         ($tmp.25 Integer)
         ($tmp.26 Integer)
         ($tmp.27 Integer)
         ($tmp.28 Integer)
         ($tmp.29 Integer)
         ($tmp.3 Integer)
         ($tmp.30 Integer)
         ($tmp.31 (Function (Integer) Integer))
         ($tmp.32 Integer)
         ($tmp.33 Integer)
         ($tmp.34 Integer)
         ($tmp.35 Integer)
         ($tmp.36 Integer)
         ($tmp.37 Integer)
         ($tmp.38 Integer)
         ($tmp.39 Integer)
         ($tmp.4 Integer)
         ($tmp.40 Integer)
         ($tmp.41 Integer)
         ($tmp.42 Integer)
         ($tmp.43 Integer)
         ($tmp.44 Integer)
         ($tmp.45 Integer)
         ($tmp.46 Integer)
         ($tmp.47 Integer)
         ($tmp.48 Integer)
         ($tmp.49 Integer)
         ($tmp.5 Integer)
         ($tmp.50 Integer)
         ($tmp.51 Integer)
         ($tmp.6 Integer)
         ($tmp.7 Integer)
         ($tmp.8 Integer)
         ($tmp.9 Integer)
         (_.1 Unit)
         (_.10 Unit)
         (_.11 Unit)
         (_.12 Unit)
         (_.13 Unit)
         (_.14 Unit)
         (_.15 Unit)
         (_.16 Unit)
         (_.17 Unit)
         (_.18 Unit)
         (_.19 Unit)
         (_.2 Unit)
         (_.20 Unit)
         (_.3 Unit)
         (_.4 Unit)
         (_.5 Unit)
         (_.6 Unit)
         (_.7 Unit)
         (_.8 Unit)
         (_.9 Unit)
         (g (Function (Integer) Integer))
         (v1.1 (Vector (Integer)))
         (v10.1 (Vector (Integer)))
         (v2.1 (Vector (Integer)))
         (v3.1 (Vector (Integer)))
         (v4.1 (Vector (Integer)))
         (v5.1 (Vector (Integer)))
         (v6.1 (Vector (Integer)))
         (v7.1 (Vector (Integer)))
         (v8.1 (Vector (Integer)))
         (v9.1 (Vector (Integer)))
         (y.1 Integer)))
      (body
        (((Label block_1)
          (Seq
            (Assign
              $ea.10
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.19
                (VecSet (Var $ea.10) 0 (Int 1)))
              (Seq
                (Assign v10.1 (Atm (Var $ea.10)))
                (Seq
                  (Assign $tmp.31 (FunRef (Label g) 1))
                  (Seq
                    (Assign
                      y.1
                      (Call (Var $tmp.31) ((Int 1000))))
                    (Seq
                      (Assign
                        $tmp.32
                        (Prim Add ((Int 32) (Var y.1))))
                      (Seq
                        (Assign $tmp.33 (VecRef (Var v1.1) 0))
                        (Seq
                          (Assign $tmp.34 (VecRef (Var v2.1) 0))
                          (Seq
                            (Assign $tmp.35 (VecRef (Var v3.1) 0))
                            (Seq
                              (Assign $tmp.36 (VecRef (Var v4.1) 0))
                              (Seq
                                (Assign $tmp.37 (VecRef (Var v5.1) 0))
                                (Seq
                                  (Assign $tmp.38 (VecRef (Var v6.1) 0))
                                  (Seq
                                    (Assign $tmp.39 (VecRef (Var v7.1) 0))
                                    (Seq
                                      (Assign $tmp.40 (VecRef (Var v8.1) 0))
                                      (Seq
                                        (Assign $tmp.41 (VecRef (Var v9.1) 0))
                                        (Seq
                                          (Assign $tmp.42 (VecRef (Var v10.1) 0))
                                          (Seq
                                            (Assign
                                              $tmp.43
                                              (Prim Add ((Var $tmp.41) (Var $tmp.42))))
                                            (Seq
                                              (Assign
                                                $tmp.44
                                                (Prim Add ((Var $tmp.40) (Var $tmp.43))))
                                              (Seq
                                                (Assign
                                                  $tmp.45
                                                  (Prim Add ((Var $tmp.39) (Var $tmp.44))))
                                                (Seq
                                                  (Assign
                                                    $tmp.46
                                                    (Prim Add ((Var $tmp.38) (Var $tmp.45))))
                                                  (Seq
                                                    (Assign
                                                      $tmp.47
                                                      (Prim Add ((Var $tmp.37) (Var $tmp.46))))
                                                    (Seq
                                                      (Assign
                                                        $tmp.48
                                                        (Prim Add ((Var $tmp.36) (Var $tmp.47))))
                                                      (Seq
                                                        (Assign
                                                          $tmp.49
                                                          (Prim Add ((Var $tmp.35) (Var $tmp.48))))
                                                        (Seq
                                                          (Assign
                                                            $tmp.50
                                                            (Prim Add ((Var $tmp.34) (Var $tmp.49))))
                                                          (Seq
                                                            (Assign
                                                              $tmp.51
                                                              (Prim Add ((Var $tmp.33) (Var $tmp.50))))
                                                            (Return
                                                              (Prim Add ((Var $tmp.32) (Var $tmp.51))))))))))))))))))))))))))))))
         ((Label block_10)
          (Seq
            (Assign
              $ea.7
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.13
                (VecSet (Var $ea.7) 0 (Int 1)))
              (Seq
                (Assign v7.1 (Atm (Var $ea.7)))
                (Seq
                  (Assign $tmp.22 (GlobalVal free_ptr))
                  (Seq
                    (Assign
                      $tmp.23
                      (Prim Add ((Var $tmp.22) (Int 16))))
                    (Seq
                      (Assign
                        $tmp.24
                        (GlobalVal fromspace_end))
                      (IfStmt
                        (op Lt)
                        (arg1 (Var $tmp.23))
                        (arg2 (Var $tmp.24))
                        (jump_then (Label block_8))
                        (jump_else (Label block_9))))))))))
         ((Label block_11)
          (Seq
            (Assign _.14 (Atm Void))
            (Goto (Label block_10))))
         ((Label block_12)
          (Seq
            (Collect 16)
            (Goto (Label block_10))))
         ((Label block_13)
          (Seq
            (Assign
              $ea.6
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.11
                (VecSet (Var $ea.6) 0 (Int 1)))
              (Seq
                (Assign v6.1 (Atm (Var $ea.6)))
                (Seq
                  (Assign $tmp.19 (GlobalVal free_ptr))
                  (Seq
                    (Assign
                      $tmp.20
                      (Prim Add ((Var $tmp.19) (Int 16))))
                    (Seq
                      (Assign
                        $tmp.21
                        (GlobalVal fromspace_end))
                      (IfStmt
                        (op Lt)
                        (arg1 (Var $tmp.20))
                        (arg2 (Var $tmp.21))
                        (jump_then (Label block_11))
                        (jump_else (Label block_12))))))))))
         ((Label block_14)
          (Seq
            (Assign _.12 (Atm Void))
            (Goto (Label block_13))))
         ((Label block_15)
          (Seq
            (Collect 16)
            (Goto (Label block_13))))
         ((Label block_16)
          (Seq
            (Assign
              $ea.5
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.9
                (VecSet (Var $ea.5) 0 (Int 1)))
              (Seq
                (Assign v5.1 (Atm (Var $ea.5)))
                (Seq
                  (Assign $tmp.16 (GlobalVal free_ptr))
                  (Seq
                    (Assign
                      $tmp.17
                      (Prim Add ((Var $tmp.16) (Int 16))))
                    (Seq
                      (Assign
                        $tmp.18
                        (GlobalVal fromspace_end))
                      (IfStmt
                        (op Lt)
                        (arg1 (Var $tmp.17))
                        (arg2 (Var $tmp.18))
                        (jump_then (Label block_14))
                        (jump_else (Label block_15))))))))))
         ((Label block_17)
          (Seq
            (Assign _.10 (Atm Void))
            (Goto (Label block_16))))
         ((Label block_18)
          (Seq
            (Collect 16)
            (Goto (Label block_16))))
         ((Label block_19)
          (Seq
            (Assign
              $ea.4
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.7
                (VecSet (Var $ea.4) 0 (Int 1)))
              (Seq
                (Assign v4.1 (Atm (Var $ea.4)))
                (Seq
                  (Assign $tmp.13 (GlobalVal free_ptr))
                  (Seq
                    (Assign
                      $tmp.14
                      (Prim Add ((Var $tmp.13) (Int 16))))
                    (Seq
                      (Assign
                        $tmp.15
                        (GlobalVal fromspace_end))
                      (IfStmt
                        (op Lt)
                        (arg1 (Var $tmp.14))
                        (arg2 (Var $tmp.15))
                        (jump_then (Label block_17))
                        (jump_else (Label block_18))))))))))
         ((Label block_2)
          (Seq
            (Assign _.20 (Atm Void))
            (Goto (Label block_1))))
         ((Label block_20)
          (Seq
            (Assign _.8 (Atm Void))
            (Goto (Label block_19))))
         ((Label block_21)
          (Seq
            (Collect 16)
            (Goto (Label block_19))))
         ((Label block_22)
          (Seq
            (Assign
              $ea.3
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.5
                (VecSet (Var $ea.3) 0 (Int 1)))
              (Seq
                (Assign v3.1 (Atm (Var $ea.3)))
                (Seq
                  (Assign $tmp.10 (GlobalVal free_ptr))
                  (Seq
                    (Assign
                      $tmp.11
                      (Prim Add ((Var $tmp.10) (Int 16))))
                    (Seq
                      (Assign
                        $tmp.12
                        (GlobalVal fromspace_end))
                      (IfStmt
                        (op Lt)
                        (arg1 (Var $tmp.11))
                        (arg2 (Var $tmp.12))
                        (jump_then (Label block_20))
                        (jump_else (Label block_21))))))))))
         ((Label block_23)
          (Seq
            (Assign _.6 (Atm Void))
            (Goto (Label block_22))))
         ((Label block_24)
          (Seq
            (Collect 16)
            (Goto (Label block_22))))
         ((Label block_25)
          (Seq
            (Assign
              $ea.2
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.3
                (VecSet (Var $ea.2) 0 (Int 1)))
              (Seq
                (Assign v2.1 (Atm (Var $ea.2)))
                (Seq
                  (Assign $tmp.7 (GlobalVal free_ptr))
                  (Seq
                    (Assign
                      $tmp.8
                      (Prim Add ((Var $tmp.7) (Int 16))))
                    (Seq
                      (Assign
                        $tmp.9
                        (GlobalVal fromspace_end))
                      (IfStmt
                        (op Lt)
                        (arg1 (Var $tmp.8))
                        (arg2 (Var $tmp.9))
                        (jump_then (Label block_23))
                        (jump_else (Label block_24))))))))))
         ((Label block_26)
          (Seq
            (Assign _.4 (Atm Void))
            (Goto (Label block_25))))
         ((Label block_27)
          (Seq
            (Collect 16)
            (Goto (Label block_25))))
         ((Label block_28)
          (Seq
            (Assign
              $ea.1
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.1
                (VecSet (Var $ea.1) 0 (Int 1)))
              (Seq
                (Assign v1.1 (Atm (Var $ea.1)))
                (Seq
                  (Assign $tmp.4 (GlobalVal free_ptr))
                  (Seq
                    (Assign
                      $tmp.5
                      (Prim Add ((Var $tmp.4) (Int 16))))
                    (Seq
                      (Assign
                        $tmp.6
                        (GlobalVal fromspace_end))
                      (IfStmt
                        (op Lt)
                        (arg1 (Var $tmp.5))
                        (arg2 (Var $tmp.6))
                        (jump_then (Label block_26))
                        (jump_else (Label block_27))))))))))
         ((Label block_29)
          (Seq
            (Assign _.2 (Atm Void))
            (Goto (Label block_28))))
         ((Label block_3)
          (Seq
            (Collect 16)
            (Goto (Label block_1))))
         ((Label block_30)
          (Seq
            (Collect 16)
            (Goto (Label block_28))))
         ((Label block_4)
          (Seq
            (Assign
              $ea.9
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.17
                (VecSet (Var $ea.9) 0 (Int 1)))
              (Seq
                (Assign v9.1 (Atm (Var $ea.9)))
                (Seq
                  (Assign $tmp.28 (GlobalVal free_ptr))
                  (Seq
                    (Assign
                      $tmp.29
                      (Prim Add ((Var $tmp.28) (Int 16))))
                    (Seq
                      (Assign
                        $tmp.30
                        (GlobalVal fromspace_end))
                      (IfStmt
                        (op Lt)
                        (arg1 (Var $tmp.29))
                        (arg2 (Var $tmp.30))
                        (jump_then (Label block_2))
                        (jump_else (Label block_3))))))))))
         ((Label block_5)
          (Seq
            (Assign _.18 (Atm Void))
            (Goto (Label block_4))))
         ((Label block_6)
          (Seq
            (Collect 16)
            (Goto (Label block_4))))
         ((Label block_7)
          (Seq
            (Assign
              $ea.8
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.15
                (VecSet (Var $ea.8) 0 (Int 1)))
              (Seq
                (Assign v8.1 (Atm (Var $ea.8)))
                (Seq
                  (Assign $tmp.25 (GlobalVal free_ptr))
                  (Seq
                    (Assign
                      $tmp.26
                      (Prim Add ((Var $tmp.25) (Int 16))))
                    (Seq
                      (Assign
                        $tmp.27
                        (GlobalVal fromspace_end))
                      (IfStmt
                        (op Lt)
                        (arg1 (Var $tmp.26))
                        (arg2 (Var $tmp.27))
                        (jump_then (Label block_5))
                        (jump_else (Label block_6))))))))))
         ((Label block_8)
          (Seq
            (Assign _.16 (Atm Void))
            (Goto (Label block_7))))
         ((Label block_9)
          (Seq
            (Collect 16)
            (Goto (Label block_7))))
         ((Label start)
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
                  (jump_then (Label block_29))
                  (jump_else (Label block_30)))))))))))
   (Def
     (Label g)
     ((args ((x.1 Integer)))
      (ret Integer)
      (locals
        (($ea.11 (Vector (Integer)))
         ($tmp.52 Integer)
         ($tmp.53 Integer)
         ($tmp.54 Integer)
         ($tmp.55 Integer)
         ($tmp.56 Integer)
         ($tmp.57 (Function (Integer) Integer))
         (_.21 Unit)
         (_.22 Unit)
         (g (Function (Integer) Integer))
         (v.1 (Vector (Integer)))
         (x.1 Integer)))
      (body
        (((Label block_31)
          (Return (Atm (Int 0))))
         ((Label block_32)
          (Seq
            (Assign $tmp.57 (FunRef (Label g) 1))
            (Seq
              (Assign $tmp.55 (VecRef (Var v.1) 0))
              (Seq
                (Assign
                  $tmp.56
                  (Prim Sub ((Var x.1) (Var $tmp.55))))
                (TailCall (Var $tmp.57) ((Var $tmp.56)))))))
         ((Label block_33)
          (Seq
            (Assign
              $ea.11
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.21
                (VecSet (Var $ea.11) 0 (Int 1)))
              (Seq
                (Assign v.1 (Atm (Var $ea.11)))
                (IfStmt
                  (op Eq)
                  (arg1 (Var x.1))
                  (arg2 (Int 0))
                  (jump_then (Label block_31))
                  (jump_else (Label block_32)))))))
         ((Label block_34)
          (Seq
            (Assign _.22 (Atm Void))
            (Goto (Label block_33))))
         ((Label block_35)
          (Seq
            (Collect 16)
            (Goto (Label block_33))))
         ((Label start)
          (Seq
            (Assign $tmp.52 (GlobalVal free_ptr))
            (Seq
              (Assign
                $tmp.53
                (Prim Add ((Var $tmp.52) (Int 16))))
              (Seq
                (Assign
                  $tmp.54
                  (GlobalVal fromspace_end))
                (IfStmt
                  (op Lt)
                  (arg1 (Var $tmp.53))
                  (arg2 (Var $tmp.54))
                  (jump_then (Label block_34))
                  (jump_else (Label block_35)))))))))))))
