(X86Program
  (Info2
    (locals_types
      (($tmp.1 Integer)
       ($tmp.2 Integer)
       (x.1 Integer)
       (y.1 Integer)
       (z.1 Integer)))
    (conflicts
      (((VarL $tmp.1)
        ((VarL x.1) (VarL y.1) (RegL Rsp)))
       ((VarL $tmp.2) ((RegL Rsp) (RegL Rax)))
       ((VarL x.1)
        ((VarL $tmp.1)
         (VarL y.1)
         (RegL Rsp)
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
       ((VarL y.1)
        ((VarL $tmp.1)
         (VarL x.1)
         (RegL Rsp)
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
       ((VarL z.1) ((RegL Rsp)))
       ((RegL Rsp)
        ((VarL $tmp.1)
         (VarL $tmp.2)
         (VarL x.1)
         (VarL y.1)
         (VarL z.1)
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
        ((VarL $tmp.2)
         (VarL x.1)
         (VarL y.1)
         (RegL Rsp)
         (RegL Rcx)
         (RegL Rdx)
         (RegL Rsi)
         (RegL Rdi)
         (RegL R8)
         (RegL R9)
         (RegL R10)
         (RegL R11)))
       ((RegL Rcx)
        ((VarL x.1)
         (VarL y.1)
         (RegL Rsp)
         (RegL Rax)))
       ((RegL Rdx)
        ((VarL x.1)
         (VarL y.1)
         (RegL Rsp)
         (RegL Rax)))
       ((RegL Rsi)
        ((VarL x.1)
         (VarL y.1)
         (RegL Rsp)
         (RegL Rax)))
       ((RegL Rdi)
        ((VarL x.1)
         (VarL y.1)
         (RegL Rsp)
         (RegL Rax)))
       ((RegL R8)
        ((VarL x.1)
         (VarL y.1)
         (RegL Rsp)
         (RegL Rax)))
       ((RegL R9)
        ((VarL x.1)
         (VarL y.1)
         (RegL Rsp)
         (RegL Rax)))
       ((RegL R10)
        ((VarL x.1)
         (VarL y.1)
         (RegL Rsp)
         (RegL Rax)))
       ((RegL R11)
        ((VarL x.1)
         (VarL y.1)
         (RegL Rsp)
         (RegL Rax)))
       ((RegL Rflags)
        ((VarL x.1) (VarL y.1) (RegL Rsp))))))
  (((Label block_1)
    (Block
      Binfo1
      ((Movq (Var z.1) (Var $tmp.2))
       (Negq (Var $tmp.2))
       (Movq (Imm 45) (Reg Rax))
       (Addq (Var $tmp.2) (Reg Rax))
       (Jmp (Label conclusion)))))
   ((Label block_2)
    (Block
      Binfo1
      ((Movq (Var x.1) (Var z.1))
       (Addq (Imm 1) (Var z.1))
       (Jmp (Label block_1)))))
   ((Label block_3)
    (Block
      Binfo1
      ((Movq (Var y.1) (Var z.1))
       (Addq (Imm 2) (Var z.1))
       (Jmp (Label block_1)))))
   ((Label start)
    (Block
      Binfo1
      ((Callq (Label read_int) 0)
       (Movq (Reg Rax) (Var x.1))
       (Callq (Label read_int) 0)
       (Movq (Reg Rax) (Var y.1))
       (Callq (Label read_int) 0)
       (Movq (Reg Rax) (Var $tmp.1))
       (Cmpq (Imm 0) (Var $tmp.1))
       (JmpIf CC_e (Label block_2))
       (Jmp (Label block_3)))))))