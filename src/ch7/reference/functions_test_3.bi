(X86Program
  ((Def
     (Label main)
     (Finfo2
       (conflicts
         (((VarL $ea.1)
           ((VarL $tmp.4)
            (VarL _.1)
            (VarL _.2)
            (VarL _.3)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R11)))
          ((VarL $tmp.1)
           ((VarL $tmp.4) (RegL R15)))
          ((VarL $tmp.2)
           ((VarL $tmp.3) (VarL $tmp.4) (RegL R15)))
          ((VarL $tmp.3)
           ((VarL $tmp.2) (VarL $tmp.4) (RegL R15)))
          ((VarL $tmp.4)
           ((VarL $ea.1)
            (VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.3)
            (VarL _.1)
            (VarL _.2)
            (VarL _.3)
            (VarL _.4)
            (RegL Rax)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)
            (RegL R15)
            (RegL Rflags)))
          ((VarL _.1)
           ((VarL $ea.1) (VarL $tmp.4)))
          ((VarL _.2)
           ((VarL $ea.1) (VarL $tmp.4)))
          ((VarL _.3)
           ((VarL $ea.1) (VarL $tmp.4)))
          ((VarL _.4) ((VarL $tmp.4)))
          ((VarL fun) ((RegL Rsp)))
          ((RegL Rsp) ((VarL fun)))
          ((RegL Rax) ((VarL $tmp.4)))
          ((RegL Rcx)
           ((VarL $ea.1)
            (VarL $tmp.4)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)))
          ((RegL Rdx)
           ((VarL $ea.1)
            (VarL $tmp.4)
            (RegL Rcx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)))
          ((RegL Rsi)
           ((VarL $ea.1)
            (VarL $tmp.4)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)))
          ((RegL Rdi)
           ((VarL $ea.1)
            (VarL $tmp.4)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL R8)
            (RegL R9)))
          ((RegL R8)
           ((VarL $ea.1)
            (VarL $tmp.4)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R9)))
          ((RegL R9)
           ((VarL $tmp.4)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)))
          ((RegL R10) ((VarL $tmp.4)))
          ((RegL R11)
           ((VarL $ea.1) (VarL $tmp.4)))
          ((RegL R15)
           ((VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.3)
            (VarL $tmp.4)
            (RegL Rflags)))
          ((RegL Rflags)
           ((VarL $tmp.4) (RegL R15))))))
     ((nparams 0)
      (locals
        (($ea.1
           (Vector (Integer Integer Integer)))
         ($tmp.1 Integer)
         ($tmp.2 Integer)
         ($tmp.3 Integer)
         ($tmp.4
           (Function
             (Integer
               Integer
               Integer
               Integer
               Integer
               (Vector (Integer Integer Integer)))
             Integer))
         (_.1 Unit)
         (_.2 Unit)
         (_.3 Unit)
         (_.4 Unit)
         (fun
           (Function
             (Integer
               Integer
               Integer
               Integer
               Integer
               (Vector (Integer Integer Integer)))
             Integer))))
      (body
        (((Label block_1)
          (Block
            Binfo1
            ((Movq
               (GlobalArg (Label free_ptr))
               (Reg R11))
             (Addq
               (Imm 32)
               (GlobalArg (Label free_ptr)))
             (Movq (Imm 7) (Deref R11 0))
             (Movq (Reg R11) (Var $ea.1))
             (Movq (Var $ea.1) (Reg R11))
             (Movq (Imm 5) (Deref R11 8))
             (Movq (Imm 0) (Var _.3))
             (Movq (Var $ea.1) (Reg R11))
             (Movq (Imm 5) (Deref R11 16))
             (Movq (Imm 0) (Var _.2))
             (Movq (Var $ea.1) (Reg R11))
             (Movq (Imm 7) (Deref R11 24))
             (Movq (Imm 0) (Var _.1))
             (Movq (Imm 5) (Reg Rdi))
             (Movq (Imm 5) (Reg Rsi))
             (Movq (Imm 5) (Reg Rdx))
             (Movq (Imm 5) (Reg Rcx))
             (Movq (Imm 5) (Reg R8))
             (Movq (Var $ea.1) (Reg R9))
             (TailJmp (Var $tmp.4) 6))))
         ((Label block_2)
          (Block
            Binfo1
            ((Movq (Imm 0) (Var _.4))
             (Jmp (Label block_1)))))
         ((Label block_3)
          (Block
            Binfo1
            ((Movq (Reg R15) (Reg Rdi))
             (Movq (Imm 32) (Reg Rsi))
             (Callq (Label collect) 2)
             (Jmp (Label block_1)))))
         ((Label main_start)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label fun))
               (Var $tmp.4))
             (Movq
               (GlobalArg (Label free_ptr))
               (Var $tmp.1))
             (Movq (Var $tmp.1) (Var $tmp.2))
             (Addq (Imm 32) (Var $tmp.2))
             (Movq
               (GlobalArg (Label fromspace_end))
               (Var $tmp.3))
             (Cmpq (Var $tmp.3) (Var $tmp.2))
             (JmpIf CC_l (Label block_2))
             (Jmp (Label block_3)))))))))
   (Def
     (Label fun)
     (Finfo2
       (conflicts
         (((VarL $tmp.10)
           ((VarL $tmp.11)
            (VarL $tmp.9)
            (VarL x1.1)
            (VarL x2.1)
            (VarL x3.1)
            (VarL x4.1)
            (RegL Rsp)))
          ((VarL $tmp.11)
           ((VarL $tmp.10)
            (VarL $tmp.12)
            (VarL x1.1)
            (VarL x2.1)
            (VarL x3.1)
            (RegL Rsp)))
          ((VarL $tmp.12)
           ((VarL $tmp.11)
            (VarL $tmp.13)
            (VarL x1.1)
            (VarL x2.1)
            (RegL Rsp)))
          ((VarL $tmp.13)
           ((VarL $tmp.12)
            (VarL x1.1)
            (RegL Rsp)
            (RegL Rax)))
          ((VarL $tmp.5)
           ((VarL $tmp.6)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL $tup.1)
            (VarL x1.1)
            (VarL x2.1)
            (VarL x3.1)
            (VarL x4.1)
            (VarL x5.1)
            (RegL Rsp)
            (RegL R11)))
          ((VarL $tmp.6)
           ((VarL $tmp.5)
            (VarL $tmp.7)
            (VarL $tup.1)
            (VarL x1.1)
            (VarL x2.1)
            (VarL x3.1)
            (VarL x4.1)
            (VarL x5.1)
            (RegL Rsp)
            (RegL R11)))
          ((VarL $tmp.7)
           ((VarL $tmp.5)
            (VarL $tmp.6)
            (VarL $tmp.8)
            (VarL x1.1)
            (VarL x2.1)
            (VarL x3.1)
            (VarL x4.1)
            (VarL x5.1)
            (RegL Rsp)))
          ((VarL $tmp.8)
           ((VarL $tmp.5)
            (VarL $tmp.7)
            (VarL $tmp.9)
            (VarL x1.1)
            (VarL x2.1)
            (VarL x3.1)
            (VarL x4.1)
            (VarL x5.1)
            (RegL Rsp)))
          ((VarL $tmp.9)
           ((VarL $tmp.10)
            (VarL $tmp.8)
            (VarL x1.1)
            (VarL x2.1)
            (VarL x3.1)
            (VarL x4.1)
            (VarL x5.1)
            (RegL Rsp)))
          ((VarL $tup.1)
           ((VarL $tmp.5)
            (VarL $tmp.6)
            (VarL x1.1)
            (VarL x2.1)
            (VarL x3.1)
            (VarL x4.1)
            (VarL x5.1)
            (RegL Rsp)))
          ((VarL x1.1)
           ((VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.12)
            (VarL $tmp.13)
            (VarL $tmp.5)
            (VarL $tmp.6)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL $tmp.9)
            (VarL $tup.1)
            (VarL x2.1)
            (VarL x3.1)
            (VarL x4.1)
            (VarL x5.1)
            (RegL Rsp)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL R8)
            (RegL R9)
            (RegL R11)))
          ((VarL x2.1)
           ((VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.12)
            (VarL $tmp.5)
            (VarL $tmp.6)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL $tmp.9)
            (VarL $tup.1)
            (VarL x1.1)
            (VarL x3.1)
            (VarL x4.1)
            (VarL x5.1)
            (RegL Rsp)
            (RegL Rcx)
            (RegL Rdx)
            (RegL R8)
            (RegL R9)
            (RegL R11)))
          ((VarL x3.1)
           ((VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.5)
            (VarL $tmp.6)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL $tmp.9)
            (VarL $tup.1)
            (VarL x1.1)
            (VarL x2.1)
            (VarL x4.1)
            (VarL x5.1)
            (RegL Rsp)
            (RegL Rcx)
            (RegL R8)
            (RegL R9)
            (RegL R11)))
          ((VarL x4.1)
           ((VarL $tmp.10)
            (VarL $tmp.5)
            (VarL $tmp.6)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL $tmp.9)
            (VarL $tup.1)
            (VarL x1.1)
            (VarL x2.1)
            (VarL x3.1)
            (VarL x5.1)
            (RegL Rsp)
            (RegL R8)
            (RegL R9)
            (RegL R11)))
          ((VarL x5.1)
           ((VarL $tmp.5)
            (VarL $tmp.6)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL $tmp.9)
            (VarL $tup.1)
            (VarL x1.1)
            (VarL x2.1)
            (VarL x3.1)
            (VarL x4.1)
            (RegL Rsp)
            (RegL R9)
            (RegL R11)))
          ((RegL Rsp)
           ((VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.12)
            (VarL $tmp.13)
            (VarL $tmp.5)
            (VarL $tmp.6)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL $tmp.9)
            (VarL $tup.1)
            (VarL x1.1)
            (VarL x2.1)
            (VarL x3.1)
            (VarL x4.1)
            (VarL x5.1)
            (RegL Rax)
            (RegL R11)))
          ((RegL Rax) ((VarL $tmp.13) (RegL Rsp)))
          ((RegL Rcx)
           ((VarL x1.1) (VarL x2.1) (VarL x3.1)))
          ((RegL Rdx) ((VarL x1.1) (VarL x2.1)))
          ((RegL Rsi) ((VarL x1.1)))
          ((RegL R8)
           ((VarL x1.1)
            (VarL x2.1)
            (VarL x3.1)
            (VarL x4.1)))
          ((RegL R9)
           ((VarL x1.1)
            (VarL x2.1)
            (VarL x3.1)
            (VarL x4.1)
            (VarL x5.1)))
          ((RegL R11)
           ((VarL $tmp.5)
            (VarL $tmp.6)
            (VarL x1.1)
            (VarL x2.1)
            (VarL x3.1)
            (VarL x4.1)
            (VarL x5.1)
            (RegL Rsp))))))
     ((nparams 6)
      (locals
        ((x1.1 Integer)
         (x2.1 Integer)
         (x3.1 Integer)
         (x4.1 Integer)
         (x5.1 Integer)
         ($tup.1
           (Vector (Integer Integer Integer)))
         ($tmp.10 Integer)
         ($tmp.11 Integer)
         ($tmp.12 Integer)
         ($tmp.13 Integer)
         ($tmp.5 Integer)
         ($tmp.6 Integer)
         ($tmp.7 Integer)
         ($tmp.8 Integer)
         ($tmp.9 Integer)
         ($tup.1
           (Vector (Integer Integer Integer)))
         (x1.1 Integer)
         (x2.1 Integer)
         (x3.1 Integer)
         (x4.1 Integer)
         (x5.1 Integer)))
      (body
        (((Label fun_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x1.1))
             (Movq (Reg Rsi) (Var x2.1))
             (Movq (Reg Rdx) (Var x3.1))
             (Movq (Reg Rcx) (Var x4.1))
             (Movq (Reg R8) (Var x5.1))
             (Movq (Reg R9) (Var $tup.1))
             (Movq (Var $tup.1) (Reg R11))
             (Movq (Deref R11 8) (Var $tmp.5))
             (Movq (Var $tup.1) (Reg R11))
             (Movq (Deref R11 16) (Var $tmp.6))
             (Movq (Var $tup.1) (Reg R11))
             (Movq (Deref R11 24) (Var $tmp.7))
             (Movq (Var $tmp.6) (Var $tmp.8))
             (Addq (Var $tmp.7) (Var $tmp.8))
             (Movq (Var $tmp.5) (Var $tmp.9))
             (Addq (Var $tmp.8) (Var $tmp.9))
             (Movq (Var x5.1) (Var $tmp.10))
             (Addq (Var $tmp.9) (Var $tmp.10))
             (Movq (Var x4.1) (Var $tmp.11))
             (Addq (Var $tmp.10) (Var $tmp.11))
             (Movq (Var x3.1) (Var $tmp.12))
             (Addq (Var $tmp.11) (Var $tmp.12))
             (Movq (Var x2.1) (Var $tmp.13))
             (Addq (Var $tmp.12) (Var $tmp.13))
             (Movq (Var x1.1) (Reg Rax))
             (Addq (Var $tmp.13) (Reg Rax))
             (Jmp (Label fun_conclusion)))))))))))
