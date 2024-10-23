(X86Program
  (Info2
    (locals_types
      ((x.1 Integer)
       (x.2 Integer)
       (y.1 Integer)))
    (conflicts
      (((VarL x.1) ((VarL x.2) (RegL Rsp)))
       ((VarL x.2)
        ((VarL x.1) (VarL y.1) (RegL Rsp)))
       ((VarL y.1) ((VarL x.2) (RegL Rsp)))
       ((RegL Rsp)
        ((VarL x.1)
         (VarL x.2)
         (VarL y.1)
         (RegL Rax)))
       ((RegL Rax) ((RegL Rsp))))))
  (((Label start)
    (Block
      Binfo1
      ((Movq (Imm 20) (Var x.1))
       (Movq (Imm 22) (Var x.2))
       (Movq (Var x.1) (Var y.1))
       (Addq (Var x.2) (Var y.1))
       (Movq (Var y.1) (Reg Rax))
       (Jmp (Label conclusion)))))))
