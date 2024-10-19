(CProgram
  (Info
    (locals_types
      ((a.1 Integer)
       (b.1 Integer)
       (c.1 Integer)
       (d.1 Integer)
       (e.1 Integer)
       (f.1 Integer)
       (g.1 Integer)
       (h.1 Integer)
       (i.1 Integer)
       (j.1 Integer)
       (k.1 Integer)
       ($tmp.1 Integer)
       ($tmp.2 Integer)
       ($tmp.3 Integer)
       ($tmp.4 Integer)
       ($tmp.5 Integer)
       ($tmp.6 Integer)
       ($tmp.7 Integer)
       ($tmp.8 Integer)
       ($tmp.9 Integer)
       ($tmp.10 Integer))))
  (((Label start)
    (Seq
      (Assign a.1 Read)
      (Seq
        (Assign b.1 Read)
        (Seq
          (Assign c.1 Read)
          (Seq
            (Assign d.1 Read)
            (Seq
              (Assign e.1 Read)
              (Seq
                (Assign f.1 Read)
                (Seq
                  (Assign g.1 Read)
                  (Seq
                    (Assign h.1 Read)
                    (Seq
                      (Assign i.1 Read)
                      (Seq
                        (Assign j.1 Read)
                        (Seq
                          (Assign k.1 Read)
                          (Seq
                            (Assign $tmp.1 (Add (Var k.1) (Int 31)))
                            (Seq
                              (Assign
                                $tmp.2
                                (Add (Var j.1) (Var $tmp.1)))
                              (Seq
                                (Assign
                                  $tmp.3
                                  (Add (Var i.1) (Var $tmp.2)))
                                (Seq
                                  (Assign
                                    $tmp.4
                                    (Add (Var h.1) (Var $tmp.3)))
                                  (Seq
                                    (Assign
                                      $tmp.5
                                      (Add (Var g.1) (Var $tmp.4)))
                                    (Seq
                                      (Assign
                                        $tmp.6
                                        (Add (Var f.1) (Var $tmp.5)))
                                      (Seq
                                        (Assign
                                          $tmp.7
                                          (Add (Var e.1) (Var $tmp.6)))
                                        (Seq
                                          (Assign
                                            $tmp.8
                                            (Add (Var d.1) (Var $tmp.7)))
                                          (Seq
                                            (Assign
                                              $tmp.9
                                              (Add (Var c.1) (Var $tmp.8)))
                                            (Seq
                                              (Assign
                                                $tmp.10
                                                (Add (Var b.1) (Var $tmp.9)))
                                              (Return (Add (Var a.1) (Var $tmp.10)))))))))))))))))))))))))))
