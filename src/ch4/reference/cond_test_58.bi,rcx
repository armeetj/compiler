(X86Program
  (Info2
    (locals_types (($tmp.1 Boolean)))
    (conflicts
      (((VarL $tmp.1) ((RegL Rsp)))
       ((RegL Rsp)
        ((VarL $tmp.1) (RegL Rax) (RegL Rflags)))
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
      ((Movq (Imm 777) (Reg Rax))
       (Jmp (Label conclusion)))))
   ((Label start)
    (Block
      Binfo1
      ((Cmpq (Imm 0) (Imm 1))
       (Set CC_g (ByteReg Al))
       (Movzbq (ByteReg Al) (Var $tmp.1))
       (Cmpq (Var $tmp.1) (Imm 1))
       (JmpIf CC_e (Label block_1))
       (Jmp (Label block_2)))))))
