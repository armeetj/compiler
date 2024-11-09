(X86Program
  (Info2
    (locals_types ())
    (conflicts
      (((RegL Rsp) ((RegL Rax) (RegL Rflags)))
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
      ((Cmpq (Imm 1) (Imm 2))
       (JmpIf CC_ge (Label block_1))
       (Jmp (Label block_2)))))))
