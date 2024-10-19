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
       (l.1 Integer)
       (m.1 Integer)
       (n.1 Integer)
       (o.1 Integer)
       (p.1 Integer)
       (q.1 Integer)
       (r.1 Integer)
       (s.1 Integer))))
  (((Label start)
    (Seq
      (Assign a.1 (Atm (Int 42)))
      (Seq
        (Assign b.1 (Atm (Var a.1)))
        (Seq
          (Assign c.1 (Atm (Var b.1)))
          (Seq
            (Assign d.1 (Atm (Var c.1)))
            (Seq
              (Assign e.1 (Atm (Var d.1)))
              (Seq
                (Assign f.1 (Atm (Var e.1)))
                (Seq
                  (Assign g.1 (Atm (Var f.1)))
                  (Seq
                    (Assign h.1 (Atm (Var g.1)))
                    (Seq
                      (Assign i.1 (Atm (Var h.1)))
                      (Seq
                        (Assign j.1 (Atm (Var i.1)))
                        (Seq
                          (Assign k.1 (Atm (Var j.1)))
                          (Seq
                            (Assign l.1 (Atm (Var k.1)))
                            (Seq
                              (Assign m.1 (Atm (Var l.1)))
                              (Seq
                                (Assign n.1 (Atm (Var m.1)))
                                (Seq
                                  (Assign o.1 (Atm (Var n.1)))
                                  (Seq
                                    (Assign p.1 (Atm (Var o.1)))
                                    (Seq
                                      (Assign q.1 (Atm (Var p.1)))
                                      (Seq
                                        (Assign r.1 (Atm (Var q.1)))
                                        (Seq
                                          (Assign s.1 (Atm (Var r.1)))
                                          (Return (Atm (Var r.1)))))))))))))))))))))))))
