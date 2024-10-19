(CProgram
  (Info
    (locals_types
      ((x1.1 Integer)
       (x2.1 Integer)
       (x3.1 Integer)
       (x4.1 Integer)
       (x5.1 Integer)
       (x6.1 Integer)
       ($tmp.1 Integer)
       ($tmp.2 Integer)
       ($tmp.3 Integer)
       ($tmp.4 Integer)
       ($tmp.5 Integer)
       ($tmp.6 Integer)
       ($tmp.7 Integer)
       ($tmp.8 Integer)
       ($tmp.9 Integer))))
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
                                (Assign
                                  $tmp.8
                                  (Add (Var $tmp.7) (Int 0)))
                                (Seq
                                  (Assign
                                    $tmp.9
                                    (Add (Var $tmp.5) (Var $tmp.8)))
                                  (Return (Add (Var $tmp.9) (Int 42)))))))))))))))))))))
