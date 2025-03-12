(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals ())
      (body
        (((Label start)
          (Seq
            (Assign $tmp.1 (FunRef (Label zero) 1))
            (Seq
              (Assign
                $ea.1
                (Call (Var $tmp.1) ((Int 20))))
              (Seq
                (Assign $tmp.2 (FunRef (Label one) 1))
                (Seq
                  (Assign
                    $ea.2
                    (Call (Var $tmp.2) ((Int 20))))
                  (Seq
                    (Assign $tmp.3 (FunRef (Label two) 1))
                    (Seq
                      (Assign
                        $ea.3
                        (Call (Var $tmp.3) ((Int 20))))
                      (Seq
                        (Assign $tmp.4 (FunRef (Label three) 1))
                        (Seq
                          (Assign
                            $ea.4
                            (Call (Var $tmp.4) ((Int 20))))
                          (Seq
                            (Assign $tmp.5 (GlobalVal free_ptr))
                            (Seq
                              (Assign
                                $tmp.6
                                (Prim Add ((Var $tmp.5) (Int 48))))
                              (Seq
                                (Assign
                                  $tmp.7
                                  (GlobalVal fromspace_end))
                                (IfStmt
                                  (op Lt)
                                  (arg1 (Var $tmp.6))
                                  (arg2 (Var $tmp.7))
                                  (jump_then (Label block_2))
                                  (jump_else (Label block_3)))))))))))))))
         ((Label block_1)
          (Seq
            (Assign
              $ea.5
              (Allocate
                5
                (Vector
                  ((Vector ())
                   Integer
                   (Vector ((Vector ()) Integer))
                   (Vector
                     ((Vector ())
                      Integer
                      (Vector ((Vector ()) Integer))))
                   (Vector
                     ((Vector ())
                      Integer
                      (Vector ((Vector ()) Integer))
                      (Vector
                        ((Vector ())
                         Integer
                         (Vector ((Vector ()) Integer))))))))))
            (Seq
              (Assign
                _.5
                (VecSet (Var $ea.5) 0 (Var $ea.1)))
              (Seq
                (Assign
                  _.4
                  (VecSet (Var $ea.5) 1 (Int 42)))
                (Seq
                  (Assign
                    _.3
                    (VecSet (Var $ea.5) 2 (Var $ea.2)))
                  (Seq
                    (Assign
                      _.2
                      (VecSet (Var $ea.5) 3 (Var $ea.3)))
                    (Seq
                      (Assign
                        _.1
                        (VecSet (Var $ea.5) 4 (Var $ea.4)))
                      (Seq
                        (Assign $tmp.8 (VecRef (Var $ea.5) 4))
                        (Seq
                          (Assign $tmp.9 (VecRef (Var $tmp.8) 3))
                          (Seq
                            (Assign $tmp.10 (VecRef (Var $tmp.9) 2))
                            (Return (VecRef (Var $tmp.10) 1))))))))))))
         ((Label block_2)
          (Seq
            (Assign _.6 (Atm Void))
            (Goto (Label block_1))))
         ((Label block_3)
          (Seq
            (Collect 48)
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
              $tmp.11
              (Prim Negate ((Var m.1))))
            (Return
              (Prim Add ((Var n.1) (Var $tmp.11))))))))))
   (Def
     (Label zero)
     ((args ((x.1 Integer)))
      (ret (Vector ()))
      (locals ())
      (body
        (((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var x.1))
            (arg2 (Int 0))
            (jump_then (Label block_10))
            (jump_else (Label block_11))))
         ((Label block_10)
          (Seq
            (Assign $tmp.12 (GlobalVal free_ptr))
            (Seq
              (Assign
                $tmp.13
                (Prim Add ((Var $tmp.12) (Int 8))))
              (Seq
                (Assign
                  $tmp.14
                  (GlobalVal fromspace_end))
                (IfStmt
                  (op Lt)
                  (arg1 (Var $tmp.13))
                  (arg2 (Var $tmp.14))
                  (jump_then (Label block_5))
                  (jump_else (Label block_6)))))))
         ((Label block_11)
          (Seq
            (Assign $tmp.21 (FunRef (Label zero) 1))
            (Seq
              (Assign
                $tmp.19
                (FunRef (Label minus) 2))
              (Seq
                (Assign $tmp.15 (GlobalVal free_ptr))
                (Seq
                  (Assign
                    $tmp.16
                    (Prim Add ((Var $tmp.15) (Int 16))))
                  (Seq
                    (Assign
                      $tmp.17
                      (GlobalVal fromspace_end))
                    (IfStmt
                      (op Lt)
                      (arg1 (Var $tmp.16))
                      (arg2 (Var $tmp.17))
                      (jump_then (Label block_8))
                      (jump_else (Label block_9)))))))))
         ((Label block_4)
          (Seq
            (Assign $ea.6 (Allocate 0 (Vector ())))
            (Return (Atm (Var $ea.6)))))
         ((Label block_5)
          (Seq
            (Assign _.7 (Atm Void))
            (Goto (Label block_4))))
         ((Label block_6)
          (Seq (Collect 8) (Goto (Label block_4))))
         ((Label block_7)
          (Seq
            (Assign
              $ea.7
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.8
                (VecSet (Var $ea.7) 0 (Var x.1)))
              (Seq
                (Assign $tmp.18 (VecRef (Var $ea.7) 0))
                (Seq
                  (Assign
                    $tmp.20
                    (Call
                      (Var $tmp.19)
                      ((Var $tmp.18) (Int 1))))
                  (TailCall (Var $tmp.21) ((Var $tmp.20))))))))
         ((Label block_8)
          (Seq
            (Assign _.9 (Atm Void))
            (Goto (Label block_7))))
         ((Label block_9)
          (Seq
            (Collect 16)
            (Goto (Label block_7))))))))
   (Def
     (Label one)
     ((args ((x.2 Integer)))
      (ret (Vector ((Vector ()) Integer)))
      (locals ())
      (body
        (((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var x.2))
            (arg2 (Int 0))
            (jump_then (Label block_18))
            (jump_else (Label block_19))))
         ((Label block_12)
          (Seq
            (Assign
              $ea.9
              (Allocate
                2
                (Vector ((Vector ()) Integer))))
            (Seq
              (Assign
                _.11
                (VecSet (Var $ea.9) 0 (Var $ea.8)))
              (Seq
                (Assign
                  _.10
                  (VecSet (Var $ea.9) 1 (Int 42)))
                (Return (Atm (Var $ea.9)))))))
         ((Label block_13)
          (Seq
            (Assign _.12 (Atm Void))
            (Goto (Label block_12))))
         ((Label block_14)
          (Seq
            (Collect 24)
            (Goto (Label block_12))))
         ((Label block_15)
          (Seq
            (Assign
              $ea.10
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.13
                (VecSet (Var $ea.10) 0 (Var x.2)))
              (Seq
                (Assign $tmp.29 (VecRef (Var $ea.10) 0))
                (Seq
                  (Assign
                    $tmp.31
                    (Call
                      (Var $tmp.30)
                      ((Var $tmp.29) (Int 1))))
                  (TailCall (Var $tmp.32) ((Var $tmp.31))))))))
         ((Label block_16)
          (Seq
            (Assign _.14 (Atm Void))
            (Goto (Label block_15))))
         ((Label block_17)
          (Seq
            (Collect 16)
            (Goto (Label block_15))))
         ((Label block_18)
          (Seq
            (Assign $tmp.22 (FunRef (Label zero) 1))
            (Seq
              (Assign
                $ea.8
                (Call (Var $tmp.22) ((Int 20))))
              (Seq
                (Assign $tmp.23 (GlobalVal free_ptr))
                (Seq
                  (Assign
                    $tmp.24
                    (Prim Add ((Var $tmp.23) (Int 24))))
                  (Seq
                    (Assign
                      $tmp.25
                      (GlobalVal fromspace_end))
                    (IfStmt
                      (op Lt)
                      (arg1 (Var $tmp.24))
                      (arg2 (Var $tmp.25))
                      (jump_then (Label block_13))
                      (jump_else (Label block_14)))))))))
         ((Label block_19)
          (Seq
            (Assign $tmp.32 (FunRef (Label one) 1))
            (Seq
              (Assign
                $tmp.30
                (FunRef (Label minus) 2))
              (Seq
                (Assign $tmp.26 (GlobalVal free_ptr))
                (Seq
                  (Assign
                    $tmp.27
                    (Prim Add ((Var $tmp.26) (Int 16))))
                  (Seq
                    (Assign
                      $tmp.28
                      (GlobalVal fromspace_end))
                    (IfStmt
                      (op Lt)
                      (arg1 (Var $tmp.27))
                      (arg2 (Var $tmp.28))
                      (jump_then (Label block_16))
                      (jump_else (Label block_17)))))))))))))
   (Def
     (Label two)
     ((args ((x.3 Integer)))
      (ret
        (Vector
          ((Vector ())
           Integer
           (Vector ((Vector ()) Integer)))))
      (locals ())
      (body
        (((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var x.3))
            (arg2 (Int 0))
            (jump_then (Label block_26))
            (jump_else (Label block_27))))
         ((Label block_20)
          (Seq
            (Assign
              $ea.13
              (Allocate
                3
                (Vector
                  ((Vector ())
                   Integer
                   (Vector ((Vector ()) Integer))))))
            (Seq
              (Assign
                _.17
                (VecSet (Var $ea.13) 0 (Var $ea.11)))
              (Seq
                (Assign
                  _.16
                  (VecSet (Var $ea.13) 1 (Int 42)))
                (Seq
                  (Assign
                    _.15
                    (VecSet (Var $ea.13) 2 (Var $ea.12)))
                  (Return (Atm (Var $ea.13))))))))
         ((Label block_21)
          (Seq
            (Assign _.18 (Atm Void))
            (Goto (Label block_20))))
         ((Label block_22)
          (Seq
            (Collect 32)
            (Goto (Label block_20))))
         ((Label block_23)
          (Seq
            (Assign
              $ea.14
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.19
                (VecSet (Var $ea.14) 0 (Var x.3)))
              (Seq
                (Assign $tmp.41 (VecRef (Var $ea.14) 0))
                (Seq
                  (Assign
                    $tmp.43
                    (Call
                      (Var $tmp.42)
                      ((Var $tmp.41) (Int 1))))
                  (TailCall (Var $tmp.44) ((Var $tmp.43))))))))
         ((Label block_24)
          (Seq
            (Assign _.20 (Atm Void))
            (Goto (Label block_23))))
         ((Label block_25)
          (Seq
            (Collect 16)
            (Goto (Label block_23))))
         ((Label block_26)
          (Seq
            (Assign $tmp.33 (FunRef (Label zero) 1))
            (Seq
              (Assign
                $ea.11
                (Call (Var $tmp.33) ((Int 20))))
              (Seq
                (Assign $tmp.34 (FunRef (Label one) 1))
                (Seq
                  (Assign
                    $ea.12
                    (Call (Var $tmp.34) ((Int 20))))
                  (Seq
                    (Assign $tmp.35 (GlobalVal free_ptr))
                    (Seq
                      (Assign
                        $tmp.36
                        (Prim Add ((Var $tmp.35) (Int 32))))
                      (Seq
                        (Assign
                          $tmp.37
                          (GlobalVal fromspace_end))
                        (IfStmt
                          (op Lt)
                          (arg1 (Var $tmp.36))
                          (arg2 (Var $tmp.37))
                          (jump_then (Label block_21))
                          (jump_else (Label block_22)))))))))))
         ((Label block_27)
          (Seq
            (Assign $tmp.44 (FunRef (Label two) 1))
            (Seq
              (Assign
                $tmp.42
                (FunRef (Label minus) 2))
              (Seq
                (Assign $tmp.38 (GlobalVal free_ptr))
                (Seq
                  (Assign
                    $tmp.39
                    (Prim Add ((Var $tmp.38) (Int 16))))
                  (Seq
                    (Assign
                      $tmp.40
                      (GlobalVal fromspace_end))
                    (IfStmt
                      (op Lt)
                      (arg1 (Var $tmp.39))
                      (arg2 (Var $tmp.40))
                      (jump_then (Label block_24))
                      (jump_else (Label block_25)))))))))))))
   (Def
     (Label three)
     ((args ((x.4 Integer)))
      (ret
        (Vector
          ((Vector ())
           Integer
           (Vector ((Vector ()) Integer))
           (Vector
             ((Vector ())
              Integer
              (Vector ((Vector ()) Integer)))))))
      (locals ())
      (body
        (((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var x.4))
            (arg2 (Int 0))
            (jump_then (Label block_34))
            (jump_else (Label block_35))))
         ((Label block_28)
          (Seq
            (Assign
              $ea.18
              (Allocate
                4
                (Vector
                  ((Vector ())
                   Integer
                   (Vector ((Vector ()) Integer))
                   (Vector
                     ((Vector ())
                      Integer
                      (Vector ((Vector ()) Integer))))))))
            (Seq
              (Assign
                _.24
                (VecSet (Var $ea.18) 0 (Var $ea.15)))
              (Seq
                (Assign
                  _.23
                  (VecSet (Var $ea.18) 1 (Int 42)))
                (Seq
                  (Assign
                    _.22
                    (VecSet (Var $ea.18) 2 (Var $ea.16)))
                  (Seq
                    (Assign
                      _.21
                      (VecSet (Var $ea.18) 3 (Var $ea.17)))
                    (Return (Atm (Var $ea.18)))))))))
         ((Label block_29)
          (Seq
            (Assign _.25 (Atm Void))
            (Goto (Label block_28))))
         ((Label block_30)
          (Seq
            (Collect 40)
            (Goto (Label block_28))))
         ((Label block_31)
          (Seq
            (Assign
              $ea.19
              (Allocate 1 (Vector (Integer))))
            (Seq
              (Assign
                _.26
                (VecSet (Var $ea.19) 0 (Var x.4)))
              (Seq
                (Assign $tmp.54 (VecRef (Var $ea.19) 0))
                (Seq
                  (Assign
                    $tmp.56
                    (Call
                      (Var $tmp.55)
                      ((Var $tmp.54) (Int 1))))
                  (TailCall (Var $tmp.57) ((Var $tmp.56))))))))
         ((Label block_32)
          (Seq
            (Assign _.27 (Atm Void))
            (Goto (Label block_31))))
         ((Label block_33)
          (Seq
            (Collect 16)
            (Goto (Label block_31))))
         ((Label block_34)
          (Seq
            (Assign $tmp.45 (FunRef (Label zero) 1))
            (Seq
              (Assign
                $ea.15
                (Call (Var $tmp.45) ((Int 20))))
              (Seq
                (Assign $tmp.46 (FunRef (Label one) 1))
                (Seq
                  (Assign
                    $ea.16
                    (Call (Var $tmp.46) ((Int 20))))
                  (Seq
                    (Assign $tmp.47 (FunRef (Label two) 1))
                    (Seq
                      (Assign
                        $ea.17
                        (Call (Var $tmp.47) ((Int 20))))
                      (Seq
                        (Assign $tmp.48 (GlobalVal free_ptr))
                        (Seq
                          (Assign
                            $tmp.49
                            (Prim Add ((Var $tmp.48) (Int 40))))
                          (Seq
                            (Assign
                              $tmp.50
                              (GlobalVal fromspace_end))
                            (IfStmt
                              (op Lt)
                              (arg1 (Var $tmp.49))
                              (arg2 (Var $tmp.50))
                              (jump_then (Label block_29))
                              (jump_else (Label block_30)))))))))))))
         ((Label block_35)
          (Seq
            (Assign
              $tmp.57
              (FunRef (Label three) 1))
            (Seq
              (Assign
                $tmp.55
                (FunRef (Label minus) 2))
              (Seq
                (Assign $tmp.51 (GlobalVal free_ptr))
                (Seq
                  (Assign
                    $tmp.52
                    (Prim Add ((Var $tmp.51) (Int 16))))
                  (Seq
                    (Assign
                      $tmp.53
                      (GlobalVal fromspace_end))
                    (IfStmt
                      (op Lt)
                      (arg1 (Var $tmp.52))
                      (arg2 (Var $tmp.53))
                      (jump_then (Label block_32))
                      (jump_else (Label block_33)))))))))))))))
