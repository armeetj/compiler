(X86Program
  (Info2
    (locals_types
      ((x.1 Integer)
       (x.2 Integer)
       (x.3 Integer)))
    (conflicts
      (((VarL x.1) ((RegL Rsp)))
       ((VarL x.2) ((RegL Rsp)))
       ((VarL x.3) ((RegL Rsp)))
       ((RegL Rsp)
        ((VarL x.1)
         (VarL x.2)
         (VarL x.3)
         (RegL Rax)))
       ((RegL Rax) ((RegL Rsp))))))
  (((Label start)
    (Block
      Binfo1
      ((Movq (Imm 99) (Var x.1))
       (Movq (Imm 22) (Var x.2))
       (Movq (Imm 42) (Var x.3))
       (Movq (Var x.3) (Reg Rax))
       (Jmp (Label conclusion)))))))
