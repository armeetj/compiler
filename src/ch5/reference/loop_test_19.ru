(CProgram
  (Info
    (locals_types
      (($tmp.1 Integer)
       ($tmp.10 Integer)
       ($tmp.2 Integer)
       ($tmp.3 Integer)
       ($tmp.4 Integer)
       ($tmp.5 Integer)
       ($tmp.6 Integer)
       ($tmp.7 Integer)
       ($tmp.8 Integer)
       ($tmp.9 Integer)
       (M00.1 Integer)
       (M01.1 Integer)
       (M10.1 Integer)
       (M11.1 Integer)
       (i.1 Integer)
       (j.1 Integer))))
  (((Label block_1)
    (Seq
      (Assign $tmp.5 (Atm (Var j.1)))
      (Seq
        (Assign
          j.1
          (Prim Add ((Var $tmp.5) (Int 1))))
        (Goto (Label loop_2)))))
   ((Label block_2)
    (Seq
      (Assign M11.1 (Atm (Int 1)))
      (Goto (Label block_1))))
   ((Label block_3)
    (Seq
      (Assign M11.1 (Atm (Var M11.1)))
      (Goto (Label block_1))))
   ((Label block_4)
    (Seq
      (Assign $tmp.3 (Atm (Var i.1)))
      (Seq
        (Assign $tmp.4 (Atm (Var j.1)))
        (IfStmt
          (op Eq)
          (arg1 (Var $tmp.3))
          (arg2 (Var $tmp.4))
          (jump_then (Label block_2))
          (jump_else (Label block_3))))))
   ((Label block_5)
    (Seq
      (Assign $tmp.6 (Atm (Var i.1)))
      (Seq
        (Assign
          i.1
          (Prim Add ((Var $tmp.6) (Int 1))))
        (Goto (Label loop_1)))))
   ((Label block_6)
    (Seq
      (Assign
        $tmp.7
        (Prim Add ((Var M00.1) (Var M01.1))))
      (Seq
        (Assign
          $tmp.8
          (Prim Add ((Var $tmp.7) (Var M10.1))))
        (Seq
          (Assign $tmp.9 (Atm (Var M11.1)))
          (Seq
            (Assign
              $tmp.10
              (Prim Add ((Var $tmp.8) (Var $tmp.9))))
            (Return
              (Prim Add ((Var $tmp.10) (Int 40)))))))))
   ((Label loop_1)
    (Seq
      (Assign $tmp.1 (Atm (Var i.1)))
      (IfStmt
        (op Lt)
        (arg1 (Var $tmp.1))
        (arg2 (Int 2))
        (jump_then (Label loop_2))
        (jump_else (Label block_6)))))
   ((Label loop_2)
    (Seq
      (Assign $tmp.2 (Atm (Var j.1)))
      (IfStmt
        (op Lt)
        (arg1 (Var $tmp.2))
        (arg2 (Int 2))
        (jump_then (Label block_4))
        (jump_else (Label block_5)))))
   ((Label start)
    (Seq
      (Assign M00.1 (Atm (Int 1)))
      (Seq
        (Assign M01.1 (Atm (Int 0)))
        (Seq
          (Assign M10.1 (Atm (Int 0)))
          (Seq
            (Assign M11.1 (Atm (Int 0)))
            (Seq
              (Assign i.1 (Atm (Int 1)))
              (Seq
                (Assign j.1 (Atm (Int 1)))
                (Goto (Label loop_1)))))))))))
