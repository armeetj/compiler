(X86Program
  ((Def
     (Label main)
     (Finfo2
       (conflicts
         (((VarL $ea.1)
           ((VarL $tmp.5)
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
           ((VarL $tmp.5) (RegL R15)))
          ((VarL $tmp.2)
           ((VarL $tmp.3) (VarL $tmp.5) (RegL R15)))
          ((VarL $tmp.3)
           ((VarL $tmp.2) (VarL $tmp.5) (RegL R15)))
          ((VarL $tmp.4) ((RegL Rdi) (RegL R15)))
          ((VarL $tmp.5)
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
           ((VarL $ea.1) (VarL $tmp.5)))
          ((VarL _.2)
           ((VarL $ea.1) (VarL $tmp.5)))
          ((VarL _.3)
           ((VarL $ea.1) (VarL $tmp.5)))
          ((VarL _.4) ((VarL $tmp.5)))
          ((VarL rf) ((RegL Rsp)))
          ((RegL Rsp) ((VarL rf)))
          ((RegL Rax)
           ((VarL $tmp.5)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)
            (RegL R15)))
          ((RegL Rcx)
           ((VarL $ea.1)
            (VarL $tmp.5)
            (RegL Rax)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R15)))
          ((RegL Rdx)
           ((VarL $ea.1)
            (VarL $tmp.5)
            (RegL Rax)
            (RegL Rcx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R15)))
          ((RegL Rsi)
           ((VarL $ea.1)
            (VarL $tmp.5)
            (RegL Rax)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R15)))
          ((RegL Rdi)
           ((VarL $ea.1)
            (VarL $tmp.4)
            (VarL $tmp.5)
            (RegL Rax)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL R8)
            (RegL R9)
            (RegL R15)))
          ((RegL R8)
           ((VarL $ea.1)
            (VarL $tmp.5)
            (RegL Rax)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R9)
            (RegL R15)))
          ((RegL R9)
           ((VarL $tmp.5)
            (RegL Rax)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R15)))
          ((RegL R10)
           ((VarL $tmp.5) (RegL Rax) (RegL R15)))
          ((RegL R11)
           ((VarL $ea.1)
            (VarL $tmp.5)
            (RegL Rax)
            (RegL R15)))
          ((RegL R15)
           ((VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.3)
            (VarL $tmp.4)
            (VarL $tmp.5)
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
          ((RegL Rflags)
           ((VarL $tmp.5) (RegL R15))))))
     ((nparams 0)
      (locals
        (($ea.1
           (Vector (Integer Integer Integer)))
         ($tmp.1 Integer)
         ($tmp.2 Integer)
         ($tmp.3 Integer)
         ($tmp.4
           (Function
             (Integer)
             (Function
               (Integer
                 Integer
                 Integer
                 Integer
                 Integer
                 (Vector (Integer Integer Integer)))
               Integer)))
         ($tmp.5
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
         (rf
           (Function
             (Integer)
             (Function
               (Integer
                 Integer
                 Integer
                 Integer
                 Integer
                 (Vector (Integer Integer Integer)))
               Integer)))))
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
             (Movq (Imm 6) (Deref R11 16))
             (Movq (Imm 0) (Var _.2))
             (Movq (Var $ea.1) (Reg R11))
             (Movq (Imm 7) (Deref R11 24))
             (Movq (Imm 0) (Var _.1))
             (Movq (Imm 42) (Reg Rdi))
             (Movq (Imm 1) (Reg Rsi))
             (Movq (Imm 2) (Reg Rdx))
             (Movq (Imm 3) (Reg Rcx))
             (Movq (Imm 4) (Reg R8))
             (Movq (Var $ea.1) (Reg R9))
             (TailJmp (Var $tmp.5) 6))))
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
               (GlobalArg (Label rf))
               (Var $tmp.4))
             (Movq (Imm 0) (Reg Rdi))
             (IndirectCallq (Var $tmp.4) 1)
             (Movq (Reg Rax) (Var $tmp.5))
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
     (Label f)
     (Finfo2
       (conflicts
         (((VarL $tup.1) ((VarL x1.1) (RegL Rsp)))
          ((VarL x1.1)
           ((VarL $tup.1)
            (VarL x2.1)
            (VarL x3.1)
            (VarL x4.1)
            (VarL x5.1)
            (RegL Rsp)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL R8)
            (RegL R9)))
          ((VarL x2.1)
           ((VarL x1.1)
            (RegL Rsp)
            (RegL Rcx)
            (RegL Rdx)
            (RegL R8)
            (RegL R9)))
          ((VarL x3.1)
           ((VarL x1.1)
            (RegL Rsp)
            (RegL Rcx)
            (RegL R8)
            (RegL R9)))
          ((VarL x4.1)
           ((VarL x1.1)
            (RegL Rsp)
            (RegL R8)
            (RegL R9)))
          ((VarL x5.1)
           ((VarL x1.1) (RegL Rsp) (RegL R9)))
          ((RegL Rsp)
           ((VarL $tup.1)
            (VarL x1.1)
            (VarL x2.1)
            (VarL x3.1)
            (VarL x4.1)
            (VarL x5.1)
            (RegL Rax)))
          ((RegL Rax) ((RegL Rsp)))
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
            (VarL x5.1))))))
     ((nparams 6)
      (locals
        ((x1.1 Integer)
         (x2.1 Integer)
         (x3.1 Integer)
         (x4.1 Integer)
         (x5.1 Integer)
         ($tup.1
           (Vector (Integer Integer Integer)))
         (x1.1 Integer)))
      (body
        (((Label f_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x1.1))
             (Movq (Reg Rsi) (Var x2.1))
             (Movq (Reg Rdx) (Var x3.1))
             (Movq (Reg Rcx) (Var x4.1))
             (Movq (Reg R8) (Var x5.1))
             (Movq (Reg R9) (Var $tup.1))
             (Movq (Var x1.1) (Reg Rax))
             (Jmp (Label f_conclusion)))))))))
   (Def
     (Label rf)
     (Finfo2
       (conflicts
         (((VarL f) ((RegL Rsp)))
          ((VarL x.1) ((RegL Rsp)))
          ((RegL Rsp)
           ((VarL f) (VarL x.1) (RegL Rax)))
          ((RegL Rax) ((RegL Rsp))))))
     ((nparams 1)
      (locals
        ((x.1 Integer)
         (f
           (Function
             (Integer
               Integer
               Integer
               Integer
               Integer
               (Vector (Integer Integer Integer)))
             Integer))))
      (body
        (((Label rf_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x.1))
             (Leaq (GlobalArg (Label f)) (Reg Rax))
             (Jmp (Label rf_conclusion)))))))))))