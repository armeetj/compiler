(X86Program
  (Info2
    (locals_types
      ((y.1 Integer) (x.1 Integer)))
    (conflicts
      (((VarL x.1) ((RegL Rsp)))
       ((VarL y.1) ((RegL Rsp)))
       ((RegL Rsp)
        ((VarL x.1) (VarL y.1) (RegL Rax)))
       ((RegL Rax) ((RegL Rsp))))))
  (((Label start)
    (Block
      Binfo1
      ((Movq (Imm 42) (Var y.1))
       (Negq (Var y.1))
       (Movq (Var y.1) (Var x.1))
       (Movq (Var x.1) (Reg Rax))
       (Negq (Reg Rax))
       (Jmp (Label conclusion)))))))
