(X86Program
  (Info2
    (locals_types
      ((x.1 Integer) (x.2 Integer)))
    (conflicts
      (((VarL x.1) ((VarL x.2) (RegL Rsp)))
       ((VarL x.2)
        ((VarL x.1) (RegL Rsp) (RegL Rax)))
       ((RegL Rsp)
        ((VarL x.1) (VarL x.2) (RegL Rax)))
       ((RegL Rax) ((VarL x.2) (RegL Rsp))))))
  (((Label start)
    (Block
      Binfo1
      ((Movq (Imm 10) (Var x.1))
       (Movq (Imm 32) (Var x.2))
       (Movq (Var x.1) (Reg Rax))
       (Addq (Var x.2) (Reg Rax))
       (Jmp (Label conclusion)))))))
