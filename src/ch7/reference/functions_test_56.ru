(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($tmp.1 (Function (Integer) Integer))
         ($tmp.10 Integer)
         ($tmp.11 (Function (Integer) Integer))
         ($tmp.12 Integer)
         ($tmp.13 Integer)
         ($tmp.14 Integer)
         ($tmp.15 Integer)
         ($tmp.16 Integer)
         ($tmp.2 Integer)
         ($tmp.3 (Function (Integer) Integer))
         ($tmp.4 Integer)
         ($tmp.5 (Function (Integer) Integer))
         ($tmp.6 Integer)
         ($tmp.7 (Function (Integer) Integer))
         ($tmp.8 Integer)
         ($tmp.9 (Function (Integer) Integer))
         (factorial (Function (Integer) Integer))))
      (body
        (((Label start)
          (Seq
            (Assign
              $tmp.1
              (FunRef (Label factorial) 1))
            (Seq
              (Assign
                $tmp.2
                (Call (Var $tmp.1) ((Int 0))))
              (Seq
                (Assign
                  $tmp.3
                  (FunRef (Label factorial) 1))
                (Seq
                  (Assign
                    $tmp.4
                    (Call (Var $tmp.3) ((Int 1))))
                  (Seq
                    (Assign
                      $tmp.5
                      (FunRef (Label factorial) 1))
                    (Seq
                      (Assign
                        $tmp.6
                        (Call (Var $tmp.5) ((Int 2))))
                      (Seq
                        (Assign
                          $tmp.7
                          (FunRef (Label factorial) 1))
                        (Seq
                          (Assign
                            $tmp.8
                            (Call (Var $tmp.7) ((Int 3))))
                          (Seq
                            (Assign
                              $tmp.9
                              (FunRef (Label factorial) 1))
                            (Seq
                              (Assign
                                $tmp.10
                                (Call (Var $tmp.9) ((Int 4))))
                              (Seq
                                (Assign
                                  $tmp.11
                                  (FunRef (Label factorial) 1))
                                (Seq
                                  (Assign
                                    $tmp.12
                                    (Call (Var $tmp.11) ((Int 5))))
                                  (Seq
                                    (Assign
                                      $tmp.13
                                      (Prim Add ((Var $tmp.10) (Var $tmp.12))))
                                    (Seq
                                      (Assign
                                        $tmp.14
                                        (Prim Add ((Var $tmp.8) (Var $tmp.13))))
                                      (Seq
                                        (Assign
                                          $tmp.15
                                          (Prim Add ((Var $tmp.6) (Var $tmp.14))))
                                        (Seq
                                          (Assign
                                            $tmp.16
                                            (Prim Add ((Var $tmp.4) (Var $tmp.15))))
                                          (Return
                                            (Prim Add ((Var $tmp.2) (Var $tmp.16)))))))))))))))))))))))))
   (Def
     (Label mult)
     ((args ((x.1 Integer) (y.1 Integer)))
      (ret Integer)
      (locals
        (($tmp.17 Integer)
         ($tmp.18 Integer)
         ($tmp.19
           (Function (Integer Integer) Integer))
         ($tmp.20 Integer)
         (mult
           (Function (Integer Integer) Integer))
         (x.1 Integer)
         (y.1 Integer)))
      (body
        (((Label block_1) (Return (Atm (Int 0))))
         ((Label block_2)
          (Seq
            (Assign $tmp.19 (FunRef (Label mult) 2))
            (Seq
              (Assign $tmp.17 (Prim Negate ((Int 1))))
              (Seq
                (Assign
                  $tmp.18
                  (Prim Add ((Var $tmp.17) (Var x.1))))
                (Seq
                  (Assign
                    $tmp.20
                    (Call
                      (Var $tmp.19)
                      ((Var $tmp.18) (Var y.1))))
                  (Return
                    (Prim Add ((Var y.1) (Var $tmp.20)))))))))
         ((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Int 0))
            (arg2 (Var x.1))
            (jump_then (Label block_1))
            (jump_else (Label block_2))))))))
   (Def
     (Label factorial)
     ((args ((n.1 Integer)))
      (ret Integer)
      (locals
        (($tmp.21 Integer)
         ($tmp.22 (Function (Integer) Integer))
         ($tmp.23 Integer)
         ($tmp.24
           (Function (Integer Integer) Integer))
         (factorial (Function (Integer) Integer))
         (mult
           (Function (Integer Integer) Integer))
         (n.1 Integer)))
      (body
        (((Label block_3) (Return (Atm (Int 1))))
         ((Label block_4)
          (Seq
            (Assign $tmp.24 (FunRef (Label mult) 2))
            (Seq
              (Assign
                $tmp.22
                (FunRef (Label factorial) 1))
              (Seq
                (Assign
                  $tmp.21
                  (Prim Sub ((Var n.1) (Int 1))))
                (Seq
                  (Assign
                    $tmp.23
                    (Call (Var $tmp.22) ((Var $tmp.21))))
                  (TailCall
                    (Var $tmp.24)
                    ((Var n.1) (Var $tmp.23))))))))
         ((Label start)
          (IfStmt
            (op Eq)
            (arg1 (Var n.1))
            (arg2 (Int 0))
            (jump_then (Label block_3))
            (jump_else (Label block_4))))))))))
