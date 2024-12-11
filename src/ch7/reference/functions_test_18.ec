(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.12 (FunRef (Label e) 1))
            (Seq
              (Assign $tmp.8 (FunRef (Label h) 1))
              (Seq
                (Assign $tmp.6 (FunRef (Label t) 1))
                (Seq
                  (Assign $tmp.4 (FunRef (Label o) 2))
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
                          (jump_else (Label block_6)))))))))))
         ((Label block_1)
          (Seq
            (Assign
              $ea.3
              (Allocate
                1
                (Vector
                  ((Vector
                     ((Vector ((Vector ((Vector (Integer))))))))))))
            (Seq
              (Assign
                _.3
                (VecSet (Var $ea.3) 0 (Var $ea.2)))
              (Seq
                (Assign
                  $tmp.13
                  (Call (Var $tmp.12) ((Var $ea.3))))
                (Seq
                  (Assign
                    $tmp.14
                    (VecRef (Var $tmp.13) 0))
                  (Seq
                    (Assign
                      $tmp.15
                      (VecRef (Var $tmp.14) 0))
                    (Seq
                      (Assign
                        $tmp.16
                        (VecRef (Var $tmp.15) 0))
                      (Seq
                        (Assign
                          $tmp.17
                          (VecRef (Var $tmp.16) 0))
                        (Seq
                          (Assign
                            $tmp.18
                            (VecRef (Var $tmp.17) 0))
                          (Return (VecRef (Var $tmp.18) 0)))))))))))
         ((Label block_2)
          (Seq
            (Assign _.4 (Atm Void))
            (Goto (Label block_1))))
         ((Label block_3)
          (Seq
            (Collect 16)
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
                (Assign
                  $tmp.5
                  (Call
                    (Var $tmp.4)
                    ((Int 1) (Var $ea.1))))
                (Seq
                  (Assign
                    $tmp.7
                    (Call (Var $tmp.6) ((Var $tmp.5))))
                  (Seq
                    (Assign
                      $ea.2
                      (Call (Var $tmp.8) ((Var $tmp.7))))
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
                            (jump_then (Label block_2))
                            (jump_else (Label block_3))))))))))))
         ((Label block_5)
          (Seq
            (Assign _.2 (Atm Void))
            (Goto (Label block_4))))
         ((Label block_6)
          (Seq
            (Collect 16)
            (Goto (Label block_4))))))))
   (Def
     (Label o)
     ((args
        ((i.1 Integer) (v.1 (Vector (Integer)))))
      (ret (Vector ((Vector (Integer)))))
      (locals ())
      (body
        (((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var i.1))
            (arg2 (Int 0))
            (jump_then (Label block_28))
            (jump_else (Label block_29))))
         ((Label block_10)
          (Seq
            (Assign
              $ea.15
              (Allocate
                5
                (Vector
                  ((Vector (Integer))
                   (Vector (Integer))
                   (Vector (Integer))
                   (Vector (Integer))
                   (Vector (Integer))))))
            (Seq
              (Assign
                _.21
                (VecSet (Var $ea.15) 0 (Var $ea.10)))
              (Seq
                (Assign
                  _.20
                  (VecSet (Var $ea.15) 1 (Var $ea.11)))
                (Seq
                  (Assign
                    _.19
                    (VecSet (Var $ea.15) 2 (Var $ea.12)))
                  (Seq
                    (Assign
                      _.18
                      (VecSet (Var $ea.15) 3 (Var $ea.13)))
                    (Seq
                      (Assign
                        _.17
                        (VecSet (Var $ea.15) 4 (Var $ea.14)))
                      (Seq
                        (Assign junk.1 (Atm (Var $ea.15)))
                        (Seq
                          (Assign $tmp.42 (FunRef (Label o) 2))
                          (Seq
                            (Assign $tmp.40 (Prim Negate ((Int 1))))
                            (Seq
                              (Assign
                                $tmp.41
                                (Prim Add ((Var i.1) (Var $tmp.40))))
                              (TailCall
                                (Var $tmp.42)
                                ((Var $tmp.41) (Var v.1))))))))))))))
         ((Label block_11)
          (Seq
            (Assign _.22 (Atm Void))
            (Goto (Label block_10))))
         ((Label block_12)
          (Seq
            (Collect 48)
            (Goto (Label block_10))))
         ((Label block_13)
          (Seq
            (Assign
              $ea.9
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.15
                (VecSet (Var $ea.9) 0 (Int 1)))
              (Seq
                (Assign $ea.14 (Atm (Var $ea.9)))
                (Seq
                  (Assign $tmp.37 (GlobalVal free_ptr))
                  (Seq
                    (Assign
                      $tmp.38
                      (Prim Add ((Var $tmp.37) (Int 48))))
                    (Seq
                      (Assign
                        $tmp.39
                        (GlobalVal fromspace_end))
                      (IfStmt
                        (op Lt)
                        (arg1 (Var $tmp.38))
                        (arg2 (Var $tmp.39))
                        (jump_then (Label block_11))
                        (jump_else (Label block_12))))))))))
         ((Label block_14)
          (Seq
            (Assign _.16 (Atm Void))
            (Goto (Label block_13))))
         ((Label block_15)
          (Seq
            (Collect 16)
            (Goto (Label block_13))))
         ((Label block_16)
          (Seq
            (Assign
              $ea.8
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.13
                (VecSet (Var $ea.8) 0 (Int 2)))
              (Seq
                (Assign $ea.13 (Atm (Var $ea.8)))
                (Seq
                  (Assign $tmp.34 (GlobalVal free_ptr))
                  (Seq
                    (Assign
                      $tmp.35
                      (Prim Add ((Var $tmp.34) (Int 16))))
                    (Seq
                      (Assign
                        $tmp.36
                        (GlobalVal fromspace_end))
                      (IfStmt
                        (op Lt)
                        (arg1 (Var $tmp.35))
                        (arg2 (Var $tmp.36))
                        (jump_then (Label block_14))
                        (jump_else (Label block_15))))))))))
         ((Label block_17)
          (Seq
            (Assign _.14 (Atm Void))
            (Goto (Label block_16))))
         ((Label block_18)
          (Seq
            (Collect 16)
            (Goto (Label block_16))))
         ((Label block_19)
          (Seq
            (Assign
              $ea.7
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.11
                (VecSet (Var $ea.7) 0 (Int 1)))
              (Seq
                (Assign $ea.12 (Atm (Var $ea.7)))
                (Seq
                  (Assign $tmp.31 (GlobalVal free_ptr))
                  (Seq
                    (Assign
                      $tmp.32
                      (Prim Add ((Var $tmp.31) (Int 16))))
                    (Seq
                      (Assign
                        $tmp.33
                        (GlobalVal fromspace_end))
                      (IfStmt
                        (op Lt)
                        (arg1 (Var $tmp.32))
                        (arg2 (Var $tmp.33))
                        (jump_then (Label block_17))
                        (jump_else (Label block_18))))))))))
         ((Label block_20)
          (Seq
            (Assign _.12 (Atm Void))
            (Goto (Label block_19))))
         ((Label block_21)
          (Seq
            (Collect 16)
            (Goto (Label block_19))))
         ((Label block_22)
          (Seq
            (Assign
              $ea.6
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.9
                (VecSet (Var $ea.6) 0 (Int 2)))
              (Seq
                (Assign $ea.11 (Atm (Var $ea.6)))
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
                        (jump_then (Label block_20))
                        (jump_else (Label block_21))))))))))
         ((Label block_23)
          (Seq
            (Assign _.10 (Atm Void))
            (Goto (Label block_22))))
         ((Label block_24)
          (Seq
            (Collect 16)
            (Goto (Label block_22))))
         ((Label block_25)
          (Seq
            (Assign
              $ea.5
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.7
                (VecSet (Var $ea.5) 0 (Int 1)))
              (Seq
                (Assign $ea.10 (Atm (Var $ea.5)))
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
                        (jump_then (Label block_23))
                        (jump_else (Label block_24))))))))))
         ((Label block_26)
          (Seq
            (Assign _.8 (Atm Void))
            (Goto (Label block_25))))
         ((Label block_27)
          (Seq
            (Collect 16)
            (Goto (Label block_25))))
         ((Label block_28)
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
                  (jump_then (Label block_8))
                  (jump_else (Label block_9)))))))
         ((Label block_29)
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
                  (jump_then (Label block_26))
                  (jump_else (Label block_27)))))))
         ((Label block_7)
          (Seq
            (Assign
              $ea.4
              (Allocate
                1
                (Vector ((Vector (Integer))))))
            (Seq
              (Assign
                _.5
                (VecSet (Var $ea.4) 0 (Var v.1)))
              (Return (Atm (Var $ea.4))))))
         ((Label block_8)
          (Seq
            (Assign _.6 (Atm Void))
            (Goto (Label block_7))))
         ((Label block_9)
          (Seq
            (Collect 16)
            (Goto (Label block_7))))))))
   (Def
     (Label t)
     ((args
        ((v.2 (Vector ((Vector (Integer)))))))
      (ret
        (Vector ((Vector ((Vector (Integer)))))))
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.43 (GlobalVal free_ptr))
            (Seq
              (Assign
                $tmp.44
                (Prim Add ((Var $tmp.43) (Int 16))))
              (Seq
                (Assign
                  $tmp.45
                  (GlobalVal fromspace_end))
                (IfStmt
                  (op Lt)
                  (arg1 (Var $tmp.44))
                  (arg2 (Var $tmp.45))
                  (jump_then (Label block_31))
                  (jump_else (Label block_32)))))))
         ((Label block_30)
          (Seq
            (Assign
              $ea.16
              (Allocate
                1
                (Vector ((Vector ((Vector (Integer))))))))
            (Seq
              (Assign
                _.23
                (VecSet (Var $ea.16) 0 (Var v.2)))
              (Return (Atm (Var $ea.16))))))
         ((Label block_31)
          (Seq
            (Assign _.24 (Atm Void))
            (Goto (Label block_30))))
         ((Label block_32)
          (Seq
            (Collect 16)
            (Goto (Label block_30))))))))
   (Def
     (Label h)
     ((args
        ((v.3
           (Vector ((Vector ((Vector (Integer)))))))))
      (ret
        (Vector
          ((Vector ((Vector ((Vector (Integer)))))))))
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.46 (GlobalVal free_ptr))
            (Seq
              (Assign
                $tmp.47
                (Prim Add ((Var $tmp.46) (Int 16))))
              (Seq
                (Assign
                  $tmp.48
                  (GlobalVal fromspace_end))
                (IfStmt
                  (op Lt)
                  (arg1 (Var $tmp.47))
                  (arg2 (Var $tmp.48))
                  (jump_then (Label block_34))
                  (jump_else (Label block_35)))))))
         ((Label block_33)
          (Seq
            (Assign
              $ea.17
              (Allocate
                1
                (Vector
                  ((Vector ((Vector ((Vector (Integer))))))))))
            (Seq
              (Assign
                _.25
                (VecSet (Var $ea.17) 0 (Var v.3)))
              (Return (Atm (Var $ea.17))))))
         ((Label block_34)
          (Seq
            (Assign _.26 (Atm Void))
            (Goto (Label block_33))))
         ((Label block_35)
          (Seq
            (Collect 16)
            (Goto (Label block_33))))))))
   (Def
     (Label f)
     ((args
        ((v.4
           (Vector
             ((Vector ((Vector ((Vector (Integer)))))))))))
      (ret
        (Vector
          ((Vector
             ((Vector ((Vector ((Vector (Integer)))))))))))
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.49 (GlobalVal free_ptr))
            (Seq
              (Assign
                $tmp.50
                (Prim Add ((Var $tmp.49) (Int 16))))
              (Seq
                (Assign
                  $tmp.51
                  (GlobalVal fromspace_end))
                (IfStmt
                  (op Lt)
                  (arg1 (Var $tmp.50))
                  (arg2 (Var $tmp.51))
                  (jump_then (Label block_37))
                  (jump_else (Label block_38)))))))
         ((Label block_36)
          (Seq
            (Assign
              $ea.18
              (Allocate
                1
                (Vector
                  ((Vector
                     ((Vector ((Vector ((Vector (Integer))))))))))))
            (Seq
              (Assign
                _.27
                (VecSet (Var $ea.18) 0 (Var v.4)))
              (Return (Atm (Var $ea.18))))))
         ((Label block_37)
          (Seq
            (Assign _.28 (Atm Void))
            (Goto (Label block_36))))
         ((Label block_38)
          (Seq
            (Collect 16)
            (Goto (Label block_36))))))))
   (Def
     (Label e)
     ((args
        ((v.5
           (Vector
             ((Vector
                ((Vector ((Vector ((Vector (Integer)))))))))))))
      (ret
        (Vector
          ((Vector
             ((Vector
                ((Vector ((Vector ((Vector (Integer)))))))))))))
      (locals ())
      (body
        (((Label start)
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
                  (jump_then (Label block_40))
                  (jump_else (Label block_41)))))))
         ((Label block_39)
          (Seq
            (Assign
              $ea.19
              (Allocate
                1
                (Vector
                  ((Vector
                     ((Vector
                        ((Vector ((Vector ((Vector (Integer))))))))))))))
            (Seq
              (Assign
                _.29
                (VecSet (Var $ea.19) 0 (Var v.5)))
              (Return (Atm (Var $ea.19))))))
         ((Label block_40)
          (Seq
            (Assign _.30 (Atm Void))
            (Goto (Label block_39))))
         ((Label block_41)
          (Seq
            (Collect 16)
            (Goto (Label block_39))))))))))
