(CProgram
  (Info (locals_types ()))
  (((Label start)
    (Seq
      (Assign $tmp.1 (GlobalVal free_ptr))
      (Seq
        (Assign
          $tmp.2
          (Prim Add ((Var $tmp.1) (Int 408))))
        (Seq
          (Assign
            $tmp.3
            (GlobalVal fromspace_end))
          (IfStmt
            (op Lt)
            (arg1 (Var $tmp.2))
            (arg2 (Var $tmp.3))
            (jump_then (Label block_2))
            (jump_else (Label block_3)))))))
   ((Label block_1)
    (Seq
      (Assign
        $ea.1
        (Allocate
          50
          (Vector
            (Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer
              Integer))))
      (Seq
        (Assign
          _.50
          (VecSet (Var $ea.1) 0 (Int 0)))
        (Seq
          (Assign
            _.49
            (VecSet (Var $ea.1) 1 (Int 1)))
          (Seq
            (Assign
              _.48
              (VecSet (Var $ea.1) 2 (Int 2)))
            (Seq
              (Assign
                _.47
                (VecSet (Var $ea.1) 3 (Int 3)))
              (Seq
                (Assign
                  _.46
                  (VecSet (Var $ea.1) 4 (Int 4)))
                (Seq
                  (Assign
                    _.45
                    (VecSet (Var $ea.1) 5 (Int 5)))
                  (Seq
                    (Assign
                      _.44
                      (VecSet (Var $ea.1) 6 (Int 6)))
                    (Seq
                      (Assign
                        _.43
                        (VecSet (Var $ea.1) 7 (Int 7)))
                      (Seq
                        (Assign
                          _.42
                          (VecSet (Var $ea.1) 8 (Int 8)))
                        (Seq
                          (Assign
                            _.41
                            (VecSet (Var $ea.1) 9 (Int 9)))
                          (Seq
                            (Assign
                              _.40
                              (VecSet (Var $ea.1) 10 (Int 10)))
                            (Seq
                              (Assign
                                _.39
                                (VecSet (Var $ea.1) 11 (Int 11)))
                              (Seq
                                (Assign
                                  _.38
                                  (VecSet (Var $ea.1) 12 (Int 12)))
                                (Seq
                                  (Assign
                                    _.37
                                    (VecSet (Var $ea.1) 13 (Int 13)))
                                  (Seq
                                    (Assign
                                      _.36
                                      (VecSet (Var $ea.1) 14 (Int 14)))
                                    (Seq
                                      (Assign
                                        _.35
                                        (VecSet (Var $ea.1) 15 (Int 15)))
                                      (Seq
                                        (Assign
                                          _.34
                                          (VecSet (Var $ea.1) 16 (Int 16)))
                                        (Seq
                                          (Assign
                                            _.33
                                            (VecSet (Var $ea.1) 17 (Int 17)))
                                          (Seq
                                            (Assign
                                              _.32
                                              (VecSet (Var $ea.1) 18 (Int 18)))
                                            (Seq
                                              (Assign
                                                _.31
                                                (VecSet (Var $ea.1) 19 (Int 19)))
                                              (Seq
                                                (Assign
                                                  _.30
                                                  (VecSet (Var $ea.1) 20 (Int 20)))
                                                (Seq
                                                  (Assign
                                                    _.29
                                                    (VecSet (Var $ea.1) 21 (Int 21)))
                                                  (Seq
                                                    (Assign
                                                      _.28
                                                      (VecSet (Var $ea.1) 22 (Int 22)))
                                                    (Seq
                                                      (Assign
                                                        _.27
                                                        (VecSet (Var $ea.1) 23 (Int 23)))
                                                      (Seq
                                                        (Assign
                                                          _.26
                                                          (VecSet (Var $ea.1) 24 (Int 24)))
                                                        (Seq
                                                          (Assign
                                                            _.25
                                                            (VecSet (Var $ea.1) 25 (Int 25)))
                                                          (Seq
                                                            (Assign
                                                              _.24
                                                              (VecSet (Var $ea.1) 26 (Int 26)))
                                                            (Seq
                                                              (Assign
                                                                _.23
                                                                (VecSet (Var $ea.1) 27 (Int 27)))
                                                              (Seq
                                                                (Assign
                                                                  _.22
                                                                  (VecSet (Var $ea.1) 28 (Int 28)))
                                                                (Seq
                                                                  (Assign
                                                                    _.21
                                                                    (VecSet (Var $ea.1) 29 (Int 29)))
                                                                  (Seq
                                                                    (Assign
                                                                      _.20
                                                                      (VecSet (Var $ea.1) 30 (Int 30)))
                                                                    (Seq
                                                                      (Assign
                                                                        _.19
                                                                        (VecSet (Var $ea.1) 31 (Int 31)))
                                                                      (Seq
                                                                        (Assign
                                                                          _.18
                                                                          (VecSet (Var $ea.1) 32 (Int 32)))
                                                                        (Seq
                                                                          (Assign
                                                                            _.17
                                                                            (VecSet (Var $ea.1) 33 (Int 33)))
                                                                          (Seq
                                                                            (Assign
                                                                              _.16
                                                                              (VecSet (Var $ea.1) 34 (Int 34)))
                                                                            (Seq
                                                                              (Assign
                                                                                _.15
                                                                                (VecSet (Var $ea.1) 35 (Int 35)))
                                                                              (Seq
                                                                                (Assign
                                                                                  _.14
                                                                                  (VecSet (Var $ea.1) 36 (Int 36)))
                                                                                (Seq
                                                                                  (Assign
                                                                                    _.13
                                                                                    (VecSet (Var $ea.1) 37 (Int 37)))
                                                                                  (Seq
                                                                                    (Assign
                                                                                      _.12
                                                                                      (VecSet (Var $ea.1) 38 (Int 38)))
                                                                                    (Seq
                                                                                      (Assign
                                                                                        _.11
                                                                                        (VecSet (Var $ea.1) 39 (Int 39)))
                                                                                      (Seq
                                                                                        (Assign
                                                                                          _.10
                                                                                          (VecSet (Var $ea.1) 40 (Int 40)))
                                                                                        (Seq
                                                                                          (Assign
                                                                                            _.9
                                                                                            (VecSet (Var $ea.1) 41 (Int 41)))
                                                                                          (Seq
                                                                                            (Assign
                                                                                              _.8
                                                                                              (VecSet (Var $ea.1) 42 (Int 42)))
                                                                                            (Seq
                                                                                              (Assign
                                                                                                _.7
                                                                                                (VecSet (Var $ea.1) 43 (Int 43)))
                                                                                              (Seq
                                                                                                (Assign
                                                                                                  _.6
                                                                                                  (VecSet (Var $ea.1) 44 (Int 44)))
                                                                                                (Seq
                                                                                                  (Assign
                                                                                                    _.5
                                                                                                    (VecSet (Var $ea.1) 45 (Int 45)))
                                                                                                  (Seq
                                                                                                    (Assign
                                                                                                      _.4
                                                                                                      (VecSet (Var $ea.1) 46 (Int 46)))
                                                                                                    (Seq
                                                                                                      (Assign
                                                                                                        _.3
                                                                                                        (VecSet (Var $ea.1) 47 (Int 47)))
                                                                                                      (Seq
                                                                                                        (Assign
                                                                                                          _.2
                                                                                                          (VecSet (Var $ea.1) 48 (Int 48)))
                                                                                                        (Seq
                                                                                                          (Assign
                                                                                                            _.1
                                                                                                            (VecSet (Var $ea.1) 49 (Int 49)))
                                                                                                          (Seq
                                                                                                            (Assign v.1 (Atm (Var $ea.1)))
                                                                                                            (Return (VecRef (Var v.1) 42)))))))))))))))))))))))))))))))))))))))))))))))))))))))
   ((Label block_2)
    (Seq
      (Assign _.51 (Atm Void))
      (Goto (Label block_1))))
   ((Label block_3)
    (Seq
      (Collect 408)
      (Goto (Label block_1))))))
