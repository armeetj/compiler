(X86Program
  (Info2
    (locals_types
      (($tmp.1 Integer) ($tmp.2 Integer)))
    (conflicts
      (((VarL $tmp.1) ((RegL Rsp)))
       ((VarL $tmp.2) ((RegL Rsp)))
       ((RegL Rsp)
        ((VarL $tmp.1)
         (VarL $tmp.2)
         (RegL Rax)
         (RegL Rcx)
         (RegL Rdx)
         (RegL Rsi)
         (RegL Rdi)
         (RegL R8)
         (RegL R9)
         (RegL R10)
         (RegL R11)
         (RegL Rflags)))
       ((RegL Rax)
        ((RegL Rsp)
         (RegL Rcx)
         (RegL Rdx)
         (RegL Rsi)
         (RegL Rdi)
         (RegL R8)
         (RegL R9)
         (RegL R10)
         (RegL R11)))
       ((RegL Rcx) ((RegL Rsp) (RegL Rax)))
       ((RegL Rdx) ((RegL Rsp) (RegL Rax)))
       ((RegL Rsi) ((RegL Rsp) (RegL Rax)))
       ((RegL Rdi) ((RegL Rsp) (RegL Rax)))
       ((RegL R8) ((RegL Rsp) (RegL Rax)))
       ((RegL R9) ((RegL Rsp) (RegL Rax)))
       ((RegL R10) ((RegL Rsp) (RegL Rax)))
       ((RegL R11) ((RegL Rsp) (RegL Rax)))
       ((RegL Rflags) ((RegL Rsp))))))
  (((Label block_1)
    (Block
      Binfo1
      ((Movq (Imm 10) (Reg Rax))
       (Addq (Imm 32) (Reg Rax))
       (Jmp (Label conclusion)))))
   ((Label block_2)
    (Block
      Binfo1
      ((Movq (Imm 70) (Reg Rax))
       (Addq (Imm 7) (Reg Rax))
       (Jmp (Label conclusion)))))
   ((Label block_3)
    (Block
      Binfo1
      ((Callq (Label read_int) 0)
       (Movq (Reg Rax) (Var $tmp.2))
       (Cmpq (Imm 0) (Var $tmp.2))
       (JmpIf CC_e (Label block_1))
       (Jmp (Label block_2)))))
   ((Label start)
    (Block
      Binfo1
      ((Callq (Label read_int) 0)
       (Movq (Reg Rax) (Var $tmp.1))
       (Cmpq (Imm 1) (Var $tmp.1))
       (JmpIf CC_e (Label block_3))
       (Jmp (Label block_2)))))))
