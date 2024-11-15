(CProgram
  (Info (locals_types ()))
  (((Label start)
    (Seq
      (Assign sum.1 (Atm (Int 0)))
      (Seq
        (Assign m.1 (Prim Read ()))
        (Seq
          (Assign n.1 (Prim Read ()))
          (Seq
            (Assign i.1 (Atm (Int 1)))
            (Goto (Label loop_1)))))))
   ((Label block_1)
    (Seq
      (Assign $tmp.3 (Atm (Var sum.1)))
      (Seq
        (Assign $tmp.4 (Atm (Var i.1)))
        (Seq
          (Assign $tmp.5 (Atm (Var j.1)))
          (Seq
            (Assign
              $tmp.6
              (Prim Add ((Var $tmp.4) (Var $tmp.5))))
            (Seq
              (Assign
                sum.1
                (Prim Add ((Var $tmp.3) (Var $tmp.6))))
              (Seq
                (Assign $tmp.7 (Atm (Var j.1)))
                (Seq
                  (Assign
                    j.1
                    (Prim Add ((Var $tmp.7) (Int 1))))
                  (Goto (Label loop_2))))))))))
   ((Label block_2)
    (Seq
      (Assign $tmp.8 (Atm (Var i.1)))
      (Seq
        (Assign
          i.1
          (Prim Add ((Var $tmp.8) (Int 1))))
        (Goto (Label loop_1)))))
   ((Label block_3)
    (Seq
      (Assign j.1 (Atm (Int 1)))
      (Goto (Label loop_2))))
   ((Label block_4)
    (Return (Atm (Var sum.1))))
   ((Label loop_1)
    (Seq
      (Assign $tmp.1 (Atm (Var i.1)))
      (IfStmt
        (op Le)
        (arg1 (Var $tmp.1))
        (arg2 (Var m.1))
        (jump_then (Label block_3))
        (jump_else (Label block_4)))))
   ((Label loop_2)
    (Seq
      (Assign $tmp.2 (Atm (Var j.1)))
      (IfStmt
        (op Le)
        (arg1 (Var $tmp.2))
        (arg2 (Var n.1))
        (jump_then (Label block_1))
        (jump_else (Label block_2)))))))
