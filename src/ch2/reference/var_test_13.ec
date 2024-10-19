(CProgram
  (Info
    (locals_types
      (($tmp.1 Integer)
       ($tmp.2 Integer)
       ($tmp.3 Integer)
       ($tmp.4 Integer)
       ($tmp.5 Integer)
       ($tmp.6 Integer)
       ($tmp.7 Integer)
       ($tmp.8 Integer)
       ($tmp.9 Integer)
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
       ($tmp.30 Integer)
       ($tmp.31 Integer))))
  (((Label start)
    (Seq
      (Assign $tmp.1 (Add (Int 1) (Int 1)))
      (Seq
        (Assign $tmp.2 (Add (Int 1) (Int 1)))
        (Seq
          (Assign
            $tmp.3
            (Add (Var $tmp.1) (Var $tmp.2)))
          (Seq
            (Assign $tmp.4 (Add (Int 1) (Int 1)))
            (Seq
              (Assign $tmp.5 (Add (Int 1) (Int 1)))
              (Seq
                (Assign
                  $tmp.6
                  (Add (Var $tmp.4) (Var $tmp.5)))
                (Seq
                  (Assign
                    $tmp.7
                    (Add (Var $tmp.3) (Var $tmp.6)))
                  (Seq
                    (Assign $tmp.8 (Add (Int 1) (Int 1)))
                    (Seq
                      (Assign $tmp.9 (Add (Int 1) (Int 1)))
                      (Seq
                        (Assign
                          $tmp.10
                          (Add (Var $tmp.8) (Var $tmp.9)))
                        (Seq
                          (Assign $tmp.11 (Add (Int 1) (Int 1)))
                          (Seq
                            (Assign $tmp.12 (Add (Int 1) (Int 1)))
                            (Seq
                              (Assign
                                $tmp.13
                                (Add (Var $tmp.11) (Var $tmp.12)))
                              (Seq
                                (Assign
                                  $tmp.14
                                  (Add (Var $tmp.10) (Var $tmp.13)))
                                (Seq
                                  (Assign
                                    $tmp.15
                                    (Add (Var $tmp.7) (Var $tmp.14)))
                                  (Seq
                                    (Assign $tmp.16 (Add (Int 1) (Int 1)))
                                    (Seq
                                      (Assign $tmp.17 (Add (Int 1) (Int 1)))
                                      (Seq
                                        (Assign
                                          $tmp.18
                                          (Add (Var $tmp.16) (Var $tmp.17)))
                                        (Seq
                                          (Assign $tmp.19 (Add (Int 1) (Int 1)))
                                          (Seq
                                            (Assign $tmp.20 (Add (Int 1) (Int 1)))
                                            (Seq
                                              (Assign
                                                $tmp.21
                                                (Add (Var $tmp.19) (Var $tmp.20)))
                                              (Seq
                                                (Assign
                                                  $tmp.22
                                                  (Add (Var $tmp.18) (Var $tmp.21)))
                                                (Seq
                                                  (Assign $tmp.23 (Add (Int 1) (Int 1)))
                                                  (Seq
                                                    (Assign $tmp.24 (Add (Int 1) (Int 1)))
                                                    (Seq
                                                      (Assign
                                                        $tmp.25
                                                        (Add (Var $tmp.23) (Var $tmp.24)))
                                                      (Seq
                                                        (Assign $tmp.26 (Add (Int 1) (Int 1)))
                                                        (Seq
                                                          (Assign $tmp.27 (Add (Int 1) (Int 1)))
                                                          (Seq
                                                            (Assign
                                                              $tmp.28
                                                              (Add (Var $tmp.26) (Var $tmp.27)))
                                                            (Seq
                                                              (Assign
                                                                $tmp.29
                                                                (Add (Var $tmp.25) (Var $tmp.28)))
                                                              (Seq
                                                                (Assign
                                                                  $tmp.30
                                                                  (Add (Var $tmp.22) (Var $tmp.29)))
                                                                (Seq
                                                                  (Assign
                                                                    $tmp.31
                                                                    (Add (Var $tmp.15) (Var $tmp.30)))
                                                                  (Return (Add (Int 10) (Var $tmp.31)))))))))))))))))))))))))))))))))))))
