(X86Program
  (Info2
    (locals_types ((x.1 Boolean)))
    (conflicts
      (((VarL x.1) ((RegL Rsp)))
       ((RegL Rsp) ((VarL x.1) (RegL Rax)))
       ((RegL Rax) ((RegL Rsp))))))
  (((Label start)
    (Block
      Binfo1
      ((Movq (Imm 1) (Var x.1))
       (Movq (Imm 42) (Reg Rax))
       (Jmp (Label conclusion)))))))
