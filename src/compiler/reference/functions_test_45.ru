(CProgram
  ((Def
     (Label main)
     ((args ())
      (ret Integer)
      (locals
        (($ea.1
           (Vector
             (Integer
               Integer
               Integer
               Integer
               Integer)))
         ($ea.2
           (Vector (Integer Integer Integer)))
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
         ($tmp.3 Integer)
         ($tmp.4
           (Function
             (Integer
               Integer
               Integer
               Integer
               Integer
               (Vector
                 (Integer
                   Integer
                   Integer
                   Integer
                   Integer)))
             Integer))
         ($tmp.5 Integer)
         ($tmp.6 Integer)
         ($tmp.7 Integer)
         ($tmp.8
           (Function
             (Integer
               Integer
               Integer
               Integer
               Integer
               (Vector (Integer Integer Integer)))
             Integer))
         ($tmp.9 Integer)
         (_.1 Unit)
         (_.10 Unit)
         (_.2 Unit)
         (_.3 Unit)
         (_.4 Unit)
         (_.5 Unit)
         (_.6 Unit)
         (_.7 Unit)
         (_.8 Unit)
         (_.9 Unit)
         (a.1 Integer)
         (b.1 Integer)
         (big
           (Function
             (Integer
               Integer
               Integer
               Integer
               Integer
               (Vector
                 (Integer
                   Integer
                   Integer
                   Integer
                   Integer)))
             Integer))
         (big2
           (Function
             (Integer
               Integer
               Integer
               Integer
               Integer
               (Vector (Integer Integer Integer)))
             Integer))
         (c.1 Integer)
         (d.1 Integer)
         (e.1 Integer)
         (f.1 Integer)
         (g.1 Integer)
         (h.1 Integer)
         (i.1 Integer)
         (j.1 Integer)
         (k.1 Integer)
         (l.1 Integer)
         (m.1 Integer)
         (n.1 Integer)
         (o.1 Integer)
         (p.1 Integer)
         (q.1 Integer)
         (r.1 Integer)
         (s.1 Integer)
         (t.1 Integer)
         (u.1 Integer)))
      (body
        (((Label block_1)
          (Seq
            (Assign
              $ea.2
              (Allocate
                3
                (Vector (Integer Integer Integer))))
            (Seq
              (Assign
                _.9
                (VecSet (Var $ea.2) 0 (Int 6)))
              (Seq
                (Assign
                  _.8
                  (VecSet (Var $ea.2) 1 (Int 7)))
                (Seq
                  (Assign
                    _.7
                    (VecSet (Var $ea.2) 2 (Int 0)))
                  (Seq
                    (Assign
                      s.1
                      (Call
                        (Var $tmp.8)
                        ((Int 1)
                         (Int 2)
                         (Int 3)
                         (Int 1)
                         (Int 5)
                         (Var $ea.2))))
                    (Seq
                      (Assign t.1 (Atm (Int 1)))
                      (Seq
                        (Assign u.1 (Atm (Int 1)))
                        (Seq
                          (Assign
                            $tmp.9
                            (Prim Add ((Var u.1) (Int 21))))
                          (Seq
                            (Assign
                              $tmp.10
                              (Prim Add ((Var t.1) (Var $tmp.9))))
                            (Seq
                              (Assign
                                $tmp.11
                                (Prim Add ((Var s.1) (Var $tmp.10))))
                              (Seq
                                (Assign
                                  $tmp.12
                                  (Prim Add ((Var r.1) (Var $tmp.11))))
                                (Seq
                                  (Assign
                                    $tmp.13
                                    (Prim Add ((Var q.1) (Var $tmp.12))))
                                  (Seq
                                    (Assign
                                      $tmp.14
                                      (Prim Add ((Var p.1) (Var $tmp.13))))
                                    (Seq
                                      (Assign
                                        $tmp.15
                                        (Prim Add ((Var o.1) (Var $tmp.14))))
                                      (Seq
                                        (Assign
                                          $tmp.16
                                          (Prim Add ((Var n.1) (Var $tmp.15))))
                                        (Seq
                                          (Assign
                                            $tmp.17
                                            (Prim Add ((Var m.1) (Var $tmp.16))))
                                          (Seq
                                            (Assign
                                              $tmp.18
                                              (Prim Add ((Var l.1) (Var $tmp.17))))
                                            (Seq
                                              (Assign
                                                $tmp.19
                                                (Prim Add ((Var k.1) (Var $tmp.18))))
                                              (Seq
                                                (Assign
                                                  $tmp.20
                                                  (Prim Add ((Var j.1) (Var $tmp.19))))
                                                (Seq
                                                  (Assign
                                                    $tmp.21
                                                    (Prim Add ((Var i.1) (Var $tmp.20))))
                                                  (Seq
                                                    (Assign
                                                      $tmp.22
                                                      (Prim Add ((Var h.1) (Var $tmp.21))))
                                                    (Seq
                                                      (Assign
                                                        $tmp.23
                                                        (Prim Add ((Var g.1) (Var $tmp.22))))
                                                      (Seq
                                                        (Assign
                                                          $tmp.24
                                                          (Prim Add ((Var f.1) (Var $tmp.23))))
                                                        (Seq
                                                          (Assign
                                                            $tmp.25
                                                            (Prim Add ((Var e.1) (Var $tmp.24))))
                                                          (Seq
                                                            (Assign
                                                              $tmp.26
                                                              (Prim Add ((Var d.1) (Var $tmp.25))))
                                                            (Seq
                                                              (Assign
                                                                $tmp.27
                                                                (Prim Add ((Var c.1) (Var $tmp.26))))
                                                              (Seq
                                                                (Assign
                                                                  $tmp.28
                                                                  (Prim Add ((Var b.1) (Var $tmp.27))))
                                                                (Return
                                                                  (Prim Add ((Var a.1) (Var $tmp.28))))))))))))))))))))))))))))))))
         ((Label block_2)
          (Seq
            (Assign _.10 (Atm Void))
            (Goto (Label block_1))))
         ((Label block_3)
          (Seq
            (Collect 32)
            (Goto (Label block_1))))
         ((Label block_4)
          (Seq
            (Assign
              $ea.1
              (Allocate
                5
                (Vector
                  (Integer
                    Integer
                    Integer
                    Integer
                    Integer))))
            (Seq
              (Assign
                _.5
                (VecSet (Var $ea.1) 0 (Int 6)))
              (Seq
                (Assign
                  _.4
                  (VecSet (Var $ea.1) 1 (Int 7)))
                (Seq
                  (Assign
                    _.3
                    (VecSet (Var $ea.1) 2 (Int 8)))
                  (Seq
                    (Assign
                      _.2
                      (VecSet (Var $ea.1) 3 (Int 9)))
                    (Seq
                      (Assign
                        _.1
                        (VecSet (Var $ea.1) 4 (Int 1)))
                      (Seq
                        (Assign
                          a.1
                          (Call
                            (Var $tmp.4)
                            ((Int 1)
                             (Int 2)
                             (Int 3)
                             (Int 0)
                             (Int 5)
                             (Var $ea.1))))
                        (Seq
                          (Assign b.1 (Atm (Int 1)))
                          (Seq
                            (Assign c.1 (Atm (Int 1)))
                            (Seq
                              (Assign d.1 (Atm (Int 1)))
                              (Seq
                                (Assign e.1 (Atm (Int 1)))
                                (Seq
                                  (Assign f.1 (Atm (Int 1)))
                                  (Seq
                                    (Assign g.1 (Atm (Int 1)))
                                    (Seq
                                      (Assign h.1 (Atm (Int 1)))
                                      (Seq
                                        (Assign i.1 (Atm (Int 1)))
                                        (Seq
                                          (Assign j.1 (Atm (Int 1)))
                                          (Seq
                                            (Assign k.1 (Atm (Int 1)))
                                            (Seq
                                              (Assign l.1 (Atm (Int 1)))
                                              (Seq
                                                (Assign m.1 (Atm (Int 1)))
                                                (Seq
                                                  (Assign n.1 (Atm (Int 1)))
                                                  (Seq
                                                    (Assign o.1 (Atm (Int 1)))
                                                    (Seq
                                                      (Assign p.1 (Atm (Int 1)))
                                                      (Seq
                                                        (Assign q.1 (Atm (Int 1)))
                                                        (Seq
                                                          (Assign r.1 (Atm (Int 1)))
                                                          (Seq
                                                            (Assign $tmp.8 (FunRef (Label big2) 6))
                                                            (Seq
                                                              (Assign $tmp.5 (GlobalVal free_ptr))
                                                              (Seq
                                                                (Assign
                                                                  $tmp.6
                                                                  (Prim Add ((Var $tmp.5) (Int 32))))
                                                                (Seq
                                                                  (Assign
                                                                    $tmp.7
                                                                    (GlobalVal fromspace_end))
                                                                  (IfStmt
                                                                    (op Lt)
                                                                    (arg1 (Var $tmp.6))
                                                                    (arg2 (Var $tmp.7))
                                                                    (jump_then (Label block_2))
                                                                    (jump_else (Label block_3))))))))))))))))))))))))))))))))
         ((Label block_5)
          (Seq
            (Assign _.6 (Atm Void))
            (Goto (Label block_4))))
         ((Label block_6)
          (Seq
            (Collect 48)
            (Goto (Label block_4))))
         ((Label start)
          (Seq
            (Assign $tmp.4 (FunRef (Label big) 6))
            (Seq
              (Assign $tmp.1 (GlobalVal free_ptr))
              (Seq
                (Assign
                  $tmp.2
                  (Prim Add ((Var $tmp.1) (Int 48))))
                (Seq
                  (Assign
                    $tmp.3
                    (GlobalVal fromspace_end))
                  (IfStmt
                    (op Lt)
                    (arg1 (Var $tmp.2))
                    (arg2 (Var $tmp.3))
                    (jump_then (Label block_5))
                    (jump_else (Label block_6))))))))))))
   (Def
     (Label big)
     ((args
        ((a.2 Integer)
         (b.2 Integer)
         (c.2 Integer)
         (d.2 Integer)
         (e.2 Integer)
         ($tup.1
           (Vector
             (Integer
               Integer
               Integer
               Integer
               Integer)))))
      (ret Integer)
      (locals
        (($tmp.29 Integer)
         ($tup.1
           (Vector
             (Integer
               Integer
               Integer
               Integer
               Integer)))
         (d.2 Integer)))
      (body
        (((Label start)
          (Seq
            (Assign $tmp.29 (VecRef (Var $tup.1) 4))
            (Return
              (Prim Add ((Var d.2) (Var $tmp.29))))))))))
   (Def
     (Label big2)
     ((args
        ((a.3 Integer)
         (b.3 Integer)
         (c.3 Integer)
         (d.3 Integer)
         (e.3 Integer)
         ($tup.2
           (Vector (Integer Integer Integer)))))
      (ret Integer)
      (locals
        (($tmp.30 Integer)
         ($tup.2
           (Vector (Integer Integer Integer)))
         (d.3 Integer)))
      (body
        (((Label start)
          (Seq
            (Assign $tmp.30 (VecRef (Var $tup.2) 2))
            (Return
              (Prim Add ((Var d.3) (Var $tmp.30))))))))))))
