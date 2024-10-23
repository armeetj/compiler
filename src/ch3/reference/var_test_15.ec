(CProgram
  (Info
    (locals_types
      ((x1.1 Integer)
       (x2.1 Integer)
       (x3.1 Integer)
       (x4.1 Integer)
       (x5.1 Integer)
       (x6.1 Integer)
       (x7.1 Integer)
       (x8.1 Integer)
       (x9.1 Integer)
       (x10.1 Integer)
       (x11.1 Integer)
       (x12.1 Integer)
       (x13.1 Integer)
       (x14.1 Integer)
       (x15.1 Integer)
       (x16.1 Integer)
       ($tmp.1 Integer)
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
       ($tmp.23 Integer))))
  (((Label start)
    (Seq
      (Assign x1.1 Read)
      (Seq
        (Assign x2.1 Read)
        (Seq
          (Assign x3.1 Read)
          (Seq
            (Assign x4.1 Read)
            (Seq
              (Assign x5.1 Read)
              (Seq
                (Assign x6.1 Read)
                (Seq
                  (Assign x7.1 Read)
                  (Seq
                    (Assign x8.1 Read)
                    (Seq
                      (Assign x9.1 Read)
                      (Seq
                        (Assign x10.1 Read)
                        (Seq
                          (Assign x11.1 Read)
                          (Seq
                            (Assign x12.1 Read)
                            (Seq
                              (Assign x13.1 Read)
                              (Seq
                                (Assign x14.1 Read)
                                (Seq
                                  (Assign x15.1 Read)
                                  (Seq
                                    (Assign x16.1 Read)
                                    (Seq
                                      (Assign $tmp.1 (Negate (Var x2.1)))
                                      (Seq
                                        (Assign
                                          $tmp.2
                                          (Add (Var x1.1) (Var $tmp.1)))
                                        (Seq
                                          (Assign $tmp.3 (Negate (Var x4.1)))
                                          (Seq
                                            (Assign
                                              $tmp.4
                                              (Add (Var x3.1) (Var $tmp.3)))
                                            (Seq
                                              (Assign
                                                $tmp.5
                                                (Add (Var $tmp.2) (Var $tmp.4)))
                                              (Seq
                                                (Assign $tmp.6 (Negate (Var x6.1)))
                                                (Seq
                                                  (Assign
                                                    $tmp.7
                                                    (Add (Var x5.1) (Var $tmp.6)))
                                                  (Seq
                                                    (Assign $tmp.8 (Negate (Var x8.1)))
                                                    (Seq
                                                      (Assign
                                                        $tmp.9
                                                        (Add (Var x7.1) (Var $tmp.8)))
                                                      (Seq
                                                        (Assign
                                                          $tmp.10
                                                          (Add (Var $tmp.7) (Var $tmp.9)))
                                                        (Seq
                                                          (Assign
                                                            $tmp.11
                                                            (Add (Var $tmp.5) (Var $tmp.10)))
                                                          (Seq
                                                            (Assign $tmp.12 (Negate (Var x10.1)))
                                                            (Seq
                                                              (Assign
                                                                $tmp.13
                                                                (Add (Var x9.1) (Var $tmp.12)))
                                                              (Seq
                                                                (Assign $tmp.14 (Negate (Var x12.1)))
                                                                (Seq
                                                                  (Assign
                                                                    $tmp.15
                                                                    (Add (Var x11.1) (Var $tmp.14)))
                                                                  (Seq
                                                                    (Assign
                                                                      $tmp.16
                                                                      (Add (Var $tmp.13) (Var $tmp.15)))
                                                                    (Seq
                                                                      (Assign $tmp.17 (Negate (Var x14.1)))
                                                                      (Seq
                                                                        (Assign
                                                                          $tmp.18
                                                                          (Add (Var x13.1) (Var $tmp.17)))
                                                                        (Seq
                                                                          (Assign $tmp.19 (Negate (Var x16.1)))
                                                                          (Seq
                                                                            (Assign
                                                                              $tmp.20
                                                                              (Add (Var x15.1) (Var $tmp.19)))
                                                                            (Seq
                                                                              (Assign
                                                                                $tmp.21
                                                                                (Add (Var $tmp.18) (Var $tmp.20)))
                                                                              (Seq
                                                                                (Assign
                                                                                  $tmp.22
                                                                                  (Add (Var $tmp.16) (Var $tmp.21)))
                                                                                (Seq
                                                                                  (Assign
                                                                                    $tmp.23
                                                                                    (Add (Var $tmp.11) (Var $tmp.22)))
                                                                                  (Return (Add (Var $tmp.23) (Int 42)))))))))))))))))))))))))))))))))))))))))))))
