(X86Program
  (Info2
    (locals_types
      (($tmp.1 Integer)
       ($tmp.2 Integer)
       ($tmp.3 Integer)
       ($tmp.4 Integer)))
    (conflicts
      (((VarL $tmp.1) ((RegL Rsp)))
       ((VarL $tmp.2)
        ((VarL $tmp.3)
         (VarL $tmp.4)
         (RegL Rsp)
         (RegL Rax)
         (RegL Rcx)
         (RegL Rdx)
         (RegL Rsi)
         (RegL Rdi)
         (RegL R8)
         (RegL R9)
         (RegL R10)
         (RegL R11)))
       ((VarL $tmp.3)
        ((VarL $tmp.2) (RegL Rsp)))
       ((VarL $tmp.4)
        ((VarL $tmp.2) (RegL Rsp)))
       ((RegL Rsp)
        ((VarL $tmp.1)
         (VarL $tmp.2)
         (VarL $tmp.3)
         (VarL $tmp.4)
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
        ((VarL $tmp.2) (RegL Rsp) (RegL Rax)))
       ((RegL Rdx)
        ((VarL $tmp.2) (RegL Rsp) (RegL Rax)))
       ((RegL Rsi)
        ((VarL $tmp.2) (RegL Rsp) (RegL Rax)))
       ((RegL Rdi)
        ((VarL $tmp.2) (RegL Rsp) (RegL Rax)))
       ((RegL R8)
        ((VarL $tmp.2) (RegL Rsp) (RegL Rax)))
       ((RegL R9)
        ((VarL $tmp.2) (RegL Rsp) (RegL Rax)))
       ((RegL R10)
        ((VarL $tmp.2) (RegL Rsp) (RegL Rax)))
       ((RegL R11)
        ((VarL $tmp.2) (RegL Rsp) (RegL Rax)))
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
      ((Callq (Label read_int) 0)
       (Movq (Reg Rax) (Var $tmp.1))
       (Movq (Var $tmp.1) (Var $tmp.2))
       (Subq (Imm 2) (Var $tmp.2))
       (Callq (Label read_int) 0)
       (Movq (Reg Rax) (Var $tmp.3))
       (Movq (Var $tmp.3) (Var $tmp.4))
       (Addq (Imm 2) (Var $tmp.4))
       (Cmpq (Var $tmp.4) (Var $tmp.2))
       (JmpIf CC_le (Label block_1))
       (Jmp (Label block_2)))))))
