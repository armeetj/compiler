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
      ((Movq (Imm 0) (Reg Rax))
       (Jmp (Label conclusion)))))
   ((Label start)
    (Block
      Binfo1
      ((Cmpq (Imm 0) (Imm 20))
       (Set CC_e (ByteReg Al))
       (Movzbq (ByteReg Al) (Var $tmp.1))
       (Cmpq (Imm 0) (Var $tmp.1))
       (JmpIf CC_e (Label block_1))
       (Jmp (Label block_2)))))))
