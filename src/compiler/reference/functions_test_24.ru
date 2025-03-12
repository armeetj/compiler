(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($tmp.1 Integer)
         ($tmp.2 Integer)
         ($tmp.3 Integer)
         ($tmp.4
           (Function
             (Integer Integer Integer)
             Integer))
         ($tmp.5 Integer)
         (big
           (Function
             (Integer Integer Integer)
             Integer))))
      (body
        (((Label start)
          (Seq
            (Assign $tmp.4 (FunRef (Label big) 3))
            (Seq
              (Assign $tmp.1 (Prim Read ()))
              (Seq
                (Assign $tmp.2 (Prim Read ()))
                (Seq
                  (Assign $tmp.3 (Prim Read ()))
                  (Seq
                    (Assign
                      $tmp.5
                      (Call
                        (Var $tmp.4)
                        ((Var $tmp.1) (Var $tmp.2) (Var $tmp.3))))
                    (Return
                      (Prim Add ((Int 42) (Var $tmp.5))))))))))))))
   (Def
     (Label big)
     ((args
        ((x.1 Integer)
         (y.1 Integer)
         (z.1 Integer)))
      (ret Integer)
      (locals
        (($tmp.10 Integer)
         ($tmp.11 Integer)
         ($tmp.12 Integer)
         ($tmp.13 Integer)
         ($tmp.14 Integer)
         ($tmp.15 Integer)
         ($tmp.16 Integer)
         ($tmp.17 Integer)
         ($tmp.18 Integer)
         ($tmp.19 Integer)
         ($tmp.6 Integer)
         ($tmp.7 Integer)
         ($tmp.8 Integer)
         ($tmp.9 Integer)
         (x.1 Integer)
         (y.1 Integer)
         (z.1 Integer)))
      (body
        (((Label start)
          (Seq
            (Assign
              $tmp.6
              (Prim Add ((Var x.1) (Var y.1))))
            (Seq
              (Assign
                $tmp.7
                (Prim Add ((Var x.1) (Var z.1))))
              (Seq
                (Assign
                  $tmp.8
                  (Prim Add ((Var $tmp.6) (Var $tmp.7))))
                (Seq
                  (Assign
                    $tmp.9
                    (Prim Add ((Var z.1) (Var x.1))))
                  (Seq
                    (Assign
                      $tmp.10
                      (Prim Add ((Var z.1) (Var y.1))))
                    (Seq
                      (Assign
                        $tmp.11
                        (Prim Add ((Var $tmp.9) (Var $tmp.10))))
                      (Seq
                        (Assign
                          $tmp.12
                          (Prim Add ((Var $tmp.8) (Var $tmp.11))))
                        (Seq
                          (Assign
                            $tmp.13
                            (Prim Add ((Var y.1) (Var y.1))))
                          (Seq
                            (Assign
                              $tmp.14
                              (Prim Add ((Var y.1) (Var x.1))))
                            (Seq
                              (Assign
                                $tmp.15
                                (Prim Add ((Var $tmp.13) (Var $tmp.14))))
                              (Seq
                                (Assign
                                  $tmp.16
                                  (Prim Add ((Var z.1) (Var x.1))))
                                (Seq
                                  (Assign
                                    $tmp.17
                                    (Prim Add ((Var z.1) (Var z.1))))
                                  (Seq
                                    (Assign
                                      $tmp.18
                                      (Prim Add ((Var $tmp.16) (Var $tmp.17))))
                                    (Seq
                                      (Assign
                                        $tmp.19
                                        (Prim Add ((Var $tmp.15) (Var $tmp.18))))
                                      (Return
                                        (Prim Add ((Var $tmp.12) (Var $tmp.19)))))))))))))))))))))))))
