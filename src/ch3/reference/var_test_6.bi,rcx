(X86Program
  (Info2
    (locals_types
      ((x.1 Integer) (y.1 Integer)))
    (conflicts
      (((VarL x.1) ((VarL y.1) (RegL Rsp)))
       ((VarL y.1)
        ((VarL x.1) (RegL Rsp) (RegL Rax)))
       ((RegL Rsp)
        ((VarL x.1) (VarL y.1) (RegL Rax)))
       ((RegL Rax) ((VarL y.1) (RegL Rsp))))))
  (((Label start)
    (Block
      Binfo1
      ((Movq (Imm 20) (Var x.1))
       (Movq (Imm 22) (Var y.1))
       (Movq (Var x.1) (Reg Rax))
       (Addq (Var y.1) (Reg Rax))
       (Jmp (Label conclusion)))))))
