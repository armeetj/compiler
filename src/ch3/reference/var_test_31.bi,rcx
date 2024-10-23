(X86Program
  (Info2
    (locals_types
      ((a.1 Integer)
       (b.1 Integer)
       (c.1 Integer)
       (d.1 Integer)))
    (conflicts
      (((VarL a.1) ((RegL Rsp)))
       ((VarL b.1) ((RegL Rsp)))
       ((VarL c.1) ((RegL Rsp)))
       ((VarL d.1) ((RegL Rsp)))
       ((RegL Rsp)
        ((VarL a.1)
         (VarL b.1)
         (VarL c.1)
         (VarL d.1)
         (RegL Rax)))
       ((RegL Rax) ((RegL Rsp))))))
  (((Label start)
    (Block
      Binfo1
      ((Movq (Imm 42) (Var a.1))
       (Movq (Var a.1) (Var b.1))
       (Movq (Var b.1) (Var c.1))
       (Movq (Var c.1) (Var d.1))
       (Movq (Var d.1) (Reg Rax))
       (Jmp (Label conclusion)))))))
