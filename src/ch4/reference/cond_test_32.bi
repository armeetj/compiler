(X86Program
  (Info2
    (locals_types
      (($tmp.1 Integer)
       (a.1 Integer)
       (b.1 Integer)
       (x.1 Integer)))
    (conflicts
      (((VarL $tmp.1)
        ((VarL a.1) (VarL b.1) (RegL Rsp)))
       ((VarL a.1)
        ((VarL $tmp.1)
         (VarL b.1)
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
       ((VarL b.1)
        ((VarL $tmp.1)
         (VarL a.1)
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
       ((VarL x.1) ((RegL Rsp)))
       ((RegL Rsp)
        ((VarL $tmp.1)
         (VarL a.1)
         (VarL b.1)
         (VarL x.1)
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
        ((VarL a.1)
         (VarL b.1)
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
        ((VarL a.1)
         (VarL b.1)
         (RegL Rsp)
         (RegL Rax)))
       ((RegL Rdx)
        ((VarL a.1)
         (VarL b.1)
         (RegL Rsp)
         (RegL Rax)))
       ((RegL Rsi)
        ((VarL a.1)
         (VarL b.1)
         (RegL Rsp)
         (RegL Rax)))
       ((RegL Rdi)
        ((VarL a.1)
         (VarL b.1)
         (RegL Rsp)
         (RegL Rax)))
       ((RegL R8)
        ((VarL a.1)
         (VarL b.1)
         (RegL Rsp)
         (RegL Rax)))
       ((RegL R9)
        ((VarL a.1)
         (VarL b.1)
         (RegL Rsp)
         (RegL Rax)))
       ((RegL R10)
        ((VarL a.1)
         (VarL b.1)
         (RegL Rsp)
         (RegL Rax)))
       ((RegL R11)
        ((VarL a.1)
         (VarL b.1)
         (RegL Rsp)
         (RegL Rax)))
       ((RegL Rflags)
        ((VarL a.1) (VarL b.1) (RegL Rsp))))))
  (((Label block_1)
    (Block
      Binfo1
      ((Movq (Var x.1) (Reg Rax))
       (Addq (Imm 10) (Reg Rax))
       (Jmp (Label conclusion)))))
   ((Label block_2)
    (Block
      Binfo1
      ((Movq (Var a.1) (Var x.1))
       (Negq (Var x.1))
       (Jmp (Label block_1)))))
   ((Label block_3)
    (Block
      Binfo1
      ((Movq (Var b.1) (Var x.1))
       (Jmp (Label block_1)))))
   ((Label start)
    (Block
      Binfo1
      ((Movq (Imm 1) (Var a.1))
       (Movq (Imm 2) (Var b.1))
       (Callq (Label read_int) 0)
       (Movq (Reg Rax) (Var $tmp.1))
       (Cmpq (Imm 0) (Var $tmp.1))
       (JmpIf CC_e (Label block_2))
       (Jmp (Label block_3)))))))
