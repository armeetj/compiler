(X86Program
  (Info2
    (locals_types ((x.1 Boolean)))
    (conflicts
      (((VarL x.1) ((RegL Rsp)))
       ((RegL Rsp)
        ((VarL x.1) (RegL Rax) (RegL Rflags)))
       ((RegL Rax) ((RegL Rsp)))
       ((RegL Rflags) ((RegL Rsp))))))
  (((Label block_1)
    (Block
      Binfo1
      ((Movq (Imm 42) (Reg Rax))
       (Jmp (Label conclusion)))))
   ((Label block_2)
    (Block
      Binfo1
      ((Movq (Imm 0) (Reg Rax))
       (Jmp (Label conclusion)))))
   ((Label start)
    (Block
      Binfo1
      ((Movq (Imm 0) (Var x.1))
       (Movq (Imm 1) (Var x.1))
       (Cmpq (Imm 1) (Var x.1))
       (JmpIf CC_e (Label block_1))
       (Jmp (Label block_2)))))))
