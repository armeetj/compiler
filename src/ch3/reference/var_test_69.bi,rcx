(X86Program
  (Info2
    (locals_types
      ((c.1 Integer)
       (b.1 Integer)
       (a.1 Integer)))
    (conflicts
      (((VarL a.1) ((RegL Rsp)))
       ((VarL b.1) ((RegL Rsp)))
       ((VarL c.1) ((RegL Rsp)))
       ((RegL Rsp)
        ((VarL a.1)
         (VarL b.1)
         (VarL c.1)
         (RegL Rax)))
       ((RegL Rax) ((RegL Rsp))))))
  (((Label start)
    (Block
      Binfo1
      ((Movq (Imm 1) (Var c.1))
       (Movq (Var c.1) (Var b.1))
       (Movq (Var b.1) (Var a.1))
       (Movq (Var a.1) (Reg Rax))
       (Jmp (Label conclusion)))))))
