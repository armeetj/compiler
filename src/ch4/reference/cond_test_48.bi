(X86Program
  (Info2
    (locals_types
      (($tmp.1 Integer)
       (x.1 Integer)
       (y.1 Integer)))
    (conflicts
      (((VarL $tmp.1) ((RegL Rsp) (RegL Rax)))
       ((VarL x.1) ((RegL Rsp)))
       ((VarL y.1) ((RegL Rsp)))
       ((RegL Rsp)
        ((VarL $tmp.1)
         (VarL x.1)
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
        ((VarL $tmp.1)
         (RegL Rsp)
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
      ((Movq (Imm 1) (Reg Rax))
       (Addq (Var $tmp.1) (Reg Rax))
       (Jmp (Label conclusion)))))
   ((Label block_2)
    (Block
      Binfo1
      ((Movq (Imm 41) (Var $tmp.1))
       (Jmp (Label block_1)))))
   ((Label block_3)
    (Block
      Binfo1
      ((Callq (Label read_int) 0)
       (Movq (Reg Rax) (Var y.1))
       (Movq (Var y.1) (Var $tmp.1))
       (Addq (Imm 7) (Var $tmp.1))
       (Jmp (Label block_1)))))
   ((Label start)
    (Block
      Binfo1
      ((Callq (Label read_int) 0)
       (Movq (Reg Rax) (Var x.1))
       (Cmpq (Var x.1) (Imm 0))
       (JmpIf CC_l (Label block_2))
       (Jmp (Label block_3)))))))
