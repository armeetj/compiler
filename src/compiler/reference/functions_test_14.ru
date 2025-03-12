(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($ea.1 (Vector ()))
         ($ea.2 (Vector ((Vector ()) Integer)))
         ($ea.3
           (Vector
             ((Vector ())
              Integer
              (Vector ((Vector ()) Integer)))))
         ($ea.4
           (Vector
             ((Vector ())
              Integer
              (Vector ((Vector ()) Integer))
              (Vector
                ((Vector ())
                 Integer
                 (Vector ((Vector ()) Integer)))))))
         ($ea.5
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
                    (Vector ((Vector ()) Integer)))))))))
         ($tmp.1
           (Function (Integer) (Vector ())))
         ($tmp.10 (Vector ((Vector ()) Integer)))
         ($tmp.2
           (Function
             (Integer)
             (Vector ((Vector ()) Integer))))
         ($tmp.3
           (Function
             (Integer)
             (Vector
               ((Vector ())
                Integer
                (Vector ((Vector ()) Integer))))))
         ($tmp.4
           (Function
             (Integer)
             (Vector
               ((Vector ())
                Integer
                (Vector ((Vector ()) Integer))
                (Vector
                  ((Vector ())
                   Integer
                   (Vector ((Vector ()) Integer))))))))
         ($tmp.5 Integer)
         ($tmp.6 Integer)
         ($tmp.7 Integer)
         ($tmp.8
           (Vector
             ((Vector ())
              Integer
              (Vector ((Vector ()) Integer))
              (Vector
                ((Vector ())
                 Integer
                 (Vector ((Vector ()) Integer)))))))
         ($tmp.9
           (Vector
             ((Vector ())
              Integer
              (Vector ((Vector ()) Integer)))))
         (_.1 Unit)
         (_.2 Unit)
         (_.3 Unit)
         (_.4 Unit)
         (_.5 Unit)
         (_.6 Unit)
         (one
           (Function
             (Integer)
             (Vector ((Vector ()) Integer))))
         (three
           (Function
             (Integer)
             (Vector
               ((Vector ())
                Integer
                (Vector ((Vector ()) Integer))
                (Vector
                  ((Vector ())
                   Integer
                   (Vector ((Vector ()) Integer))))))))
         (two
           (Function
             (Integer)
             (Vector
               ((Vector ())
                Integer
                (Vector ((Vector ()) Integer))))))
         (zero (Function (Integer) (Vector ())))))
      (body
        (((Label block_1)
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
            (Goto (Label block_1))))
         ((Label start)
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
                                  (jump_else (Label block_3)))))))))))))))))))
   (Def
     (Label minus)
     ((args ((n.1 Integer) (m.1 Integer)))
      (ret Integer)
      (locals
        (($tmp.11 Integer)
         (m.1 Integer)
         (n.1 Integer)))
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
      (locals
        (($ea.6 (Vector ()))
         ($ea.7 (Vector (Integer)))
         ($tmp.12 Integer)
         ($tmp.13 Integer)
         ($tmp.14 Integer)
         ($tmp.15 Integer)
         ($tmp.16 Integer)
         ($tmp.17 Integer)
         ($tmp.18 Integer)
         ($tmp.19
           (Function (Integer Integer) Integer))
         ($tmp.20 Integer)
         ($tmp.21
           (Function (Integer) (Vector ())))
         (_.7 Unit)
         (_.8 Unit)
         (_.9 Unit)
         (minus
           (Function (Integer Integer) Integer))
         (x.1 Integer)
         (zero (Function (Integer) (Vector ())))))
      (body
        (((Label block_10)
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
            (Goto (Label block_7))))
         ((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var x.1))
            (arg2 (Int 0))
            (jump_then (Label block_10))
            (jump_else (Label block_11))))))))
   (Def
     (Label one)
     ((args ((x.2 Integer)))
      (ret (Vector ((Vector ()) Integer)))
      (locals
        (($ea.10 (Vector (Integer)))
         ($ea.8 (Vector ()))
         ($ea.9 (Vector ((Vector ()) Integer)))
         ($tmp.22
           (Function (Integer) (Vector ())))
         ($tmp.23 Integer)
         ($tmp.24 Integer)
         ($tmp.25 Integer)
         ($tmp.26 Integer)
         ($tmp.27 Integer)
         ($tmp.28 Integer)
         ($tmp.29 Integer)
         ($tmp.30
           (Function (Integer Integer) Integer))
         ($tmp.31 Integer)
         ($tmp.32
           (Function
             (Integer)
             (Vector ((Vector ()) Integer))))
         (_.10 Unit)
         (_.11 Unit)
         (_.12 Unit)
         (_.13 Unit)
         (_.14 Unit)
         (minus
           (Function (Integer Integer) Integer))
         (one
           (Function
             (Integer)
             (Vector ((Vector ()) Integer))))
         (x.2 Integer)
         (zero (Function (Integer) (Vector ())))))
      (body
        (((Label block_12)
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
                      (jump_else (Label block_17)))))))))
         ((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var x.2))
            (arg2 (Int 0))
            (jump_then (Label block_18))
            (jump_else (Label block_19))))))))
   (Def
     (Label two)
     ((args ((x.3 Integer)))
      (ret
        (Vector
          ((Vector ())
           Integer
           (Vector ((Vector ()) Integer)))))
      (locals
        (($ea.11 (Vector ()))
         ($ea.12 (Vector ((Vector ()) Integer)))
         ($ea.13
           (Vector
             ((Vector ())
              Integer
              (Vector ((Vector ()) Integer)))))
         ($ea.14 (Vector (Integer)))
         ($tmp.33
           (Function (Integer) (Vector ())))
         ($tmp.34
           (Function
             (Integer)
             (Vector ((Vector ()) Integer))))
         ($tmp.35 Integer)
         ($tmp.36 Integer)
         ($tmp.37 Integer)
         ($tmp.38 Integer)
         ($tmp.39 Integer)
         ($tmp.40 Integer)
         ($tmp.41 Integer)
         ($tmp.42
           (Function (Integer Integer) Integer))
         ($tmp.43 Integer)
         ($tmp.44
           (Function
             (Integer)
             (Vector
               ((Vector ())
                Integer
                (Vector ((Vector ()) Integer))))))
         (_.15 Unit)
         (_.16 Unit)
         (_.17 Unit)
         (_.18 Unit)
         (_.19 Unit)
         (_.20 Unit)
         (minus
           (Function (Integer Integer) Integer))
         (one
           (Function
             (Integer)
             (Vector ((Vector ()) Integer))))
         (two
           (Function
             (Integer)
             (Vector
               ((Vector ())
                Integer
                (Vector ((Vector ()) Integer))))))
         (x.3 Integer)
         (zero (Function (Integer) (Vector ())))))
      (body
        (((Label block_20)
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
                      (jump_else (Label block_25)))))))))
         ((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var x.3))
            (arg2 (Int 0))
            (jump_then (Label block_26))
            (jump_else (Label block_27))))))))
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
      (locals
        (($ea.15 (Vector ()))
         ($ea.16 (Vector ((Vector ()) Integer)))
         ($ea.17
           (Vector
             ((Vector ())
              Integer
              (Vector ((Vector ()) Integer)))))
         ($ea.18
           (Vector
             ((Vector ())
              Integer
              (Vector ((Vector ()) Integer))
              (Vector
                ((Vector ())
                 Integer
                 (Vector ((Vector ()) Integer)))))))
         ($ea.19 (Vector (Integer)))
         ($tmp.45
           (Function (Integer) (Vector ())))
         ($tmp.46
           (Function
             (Integer)
             (Vector ((Vector ()) Integer))))
         ($tmp.47
           (Function
             (Integer)
             (Vector
               ((Vector ())
                Integer
                (Vector ((Vector ()) Integer))))))
         ($tmp.48 Integer)
         ($tmp.49 Integer)
         ($tmp.50 Integer)
         ($tmp.51 Integer)
         ($tmp.52 Integer)
         ($tmp.53 Integer)
         ($tmp.54 Integer)
         ($tmp.55
           (Function (Integer Integer) Integer))
         ($tmp.56 Integer)
         ($tmp.57
           (Function
             (Integer)
             (Vector
               ((Vector ())
                Integer
                (Vector ((Vector ()) Integer))
                (Vector
                  ((Vector ())
                   Integer
                   (Vector ((Vector ()) Integer))))))))
         (_.21 Unit)
         (_.22 Unit)
         (_.23 Unit)
         (_.24 Unit)
         (_.25 Unit)
         (_.26 Unit)
         (_.27 Unit)
         (minus
           (Function (Integer Integer) Integer))
         (one
           (Function
             (Integer)
             (Vector ((Vector ()) Integer))))
         (three
           (Function
             (Integer)
             (Vector
               ((Vector ())
                Integer
                (Vector ((Vector ()) Integer))
                (Vector
                  ((Vector ())
                   Integer
                   (Vector ((Vector ()) Integer))))))))
         (two
           (Function
             (Integer)
             (Vector
               ((Vector ())
                Integer
                (Vector ((Vector ()) Integer))))))
         (x.4 Integer)
         (zero (Function (Integer) (Vector ())))))
      (body
        (((Label block_28)
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
                      (jump_else (Label block_33)))))))))
         ((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var x.4))
            (arg2 (Int 0))
            (jump_then (Label block_34))
            (jump_else (Label block_35))))))))))
