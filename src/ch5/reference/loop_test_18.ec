(CProgram
  (Info (locals_types ()))
  (((Label start)
    (Seq
      (Assign sum.1 (Atm (Int 0)))
      (Seq
        (Assign i.1 (Atm (Int 5)))
        (Goto (Label loop_1)))))
   ((Label block_1)
    (Seq
      (Assign $tmp.2 (Atm (Var sum.1)))
      (Seq
        (Assign $tmp.3 (Atm (Var i.1)))
        (Seq
          (Assign
            sum.1
            (Prim Add ((Var $tmp.2) (Var $tmp.3))))
          (Seq
            (Assign $tmp.4 (Atm (Var i.1)))
            (Seq
              (Assign
                i.1
                (Prim Sub ((Var $tmp.4) (Int 1))))
              (Goto (Label loop_1))))))))
   ((Label block_2)
    (Seq
      (Assign $tmp.5 (Atm (Var sum.1)))
      (Seq
        (Assign $tmp.6 (Atm (Var sum.1)))
        (Seq
          (Assign
            $tmp.7
            (Prim Add ((Var $tmp.5) (Var $tmp.6))))
          (Seq
            (Assign $tmp.8 (Atm (Var sum.1)))
            (Seq
              (Assign
                $tmp.9
                (Prim Add ((Var $tmp.7) (Var $tmp.8))))
              (Return
                (Prim Sub ((Var $tmp.9) (Int 3))))))))))
   ((Label loop_1)
    (Seq
      (Assign $tmp.1 (Atm (Var i.1)))
      (IfStmt
        (op Gt)
        (arg1 (Var $tmp.1))
        (arg2 (Int 0))
        (jump_then (Label block_1))
        (jump_else (Label block_2)))))))
