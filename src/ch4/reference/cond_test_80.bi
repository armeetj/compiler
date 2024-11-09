(X86Program
  (Info2
    (locals_types
      ((x.1 Integer) (y.1 Integer)))
    (conflicts
      (((VarL x.1) ((RegL Rsp)))
       ((VarL y.1) ((RegL Rsp)))
       ((RegL Rsp)
        ((VarL x.1)
         (VarL y.1)
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
      ((Movq (Var x.1) (Reg Rax))
       (Addq (Imm 2) (Reg Rax))
       (Jmp (Label conclusion)))))
   ((Label block_2)
    (Block
      Binfo1
      ((Movq (Imm 40) (Var x.1))
       (Jmp (Label block_1)))))
   ((Label block_3)
    (Block
      Binfo1
      ((Movq (Imm 77) (Var x.1))
       (Jmp (Label block_1)))))
   ((Label start)
    (Block
      Binfo1
      ((Callq (Label read_int) 0)
       (Movq (Reg Rax) (Var y.1))
       (Cmpq (Imm 0) (Var y.1))
       (JmpIf CC_e (Label block_2))
       (Jmp (Label block_3)))))))
