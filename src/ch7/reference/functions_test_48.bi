(X86Program
  ((Def
     (Label main)
     (Finfo2
       (conflicts
         (((VarL $tmp.1) ((RegL Rsi) (RegL Rdi)))
          ((VarL f) ((RegL Rsp)))
          ((RegL Rsp) ((VarL f)))
          ((RegL Rsi) ((VarL $tmp.1) (RegL Rdi)))
          ((RegL Rdi) ((VarL $tmp.1) (RegL Rsi))))))
     ((nparams 0)
      (locals
        (($tmp.1
           (Function (Integer Integer) Integer))
         (f (Function (Integer Integer) Integer))))
      (body
        (((Label main_start)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label f))
               (Var $tmp.1))
             (Movq (Imm 11) (Reg Rdi))
             (Movq (Imm 10) (Reg Rsi))
             (TailJmp (Var $tmp.1) 2))))))))
   (Def
     (Label add)
     (Finfo2
       (conflicts
         (((VarL $ea.1)
           ((VarL $ea.2)
            (VarL $tmp.2)
            (VarL $tmp.3)
            (VarL $tmp.4)
            (VarL _.2)
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
            (RegL R15)
            (RegL Rflags)))
          ((VarL $ea.2)
           ((VarL $ea.1)
            (VarL _.1)
            (RegL Rsp)
            (RegL R11)))
          ((VarL $tmp.2)
           ((VarL $ea.1) (RegL Rsp) (RegL R15)))
          ((VarL $tmp.3)
           ((VarL $ea.1)
            (VarL $tmp.4)
            (RegL Rsp)
            (RegL R15)))
          ((VarL $tmp.4)
           ((VarL $ea.1)
            (VarL $tmp.3)
            (RegL Rsp)
            (RegL R15)))
          ((VarL _.1) ((VarL $ea.2) (RegL Rsp)))
          ((VarL _.2) ((VarL $ea.1) (RegL Rsp)))
          ((VarL x.1)
           ((VarL y.1)
            (RegL Rsp)
            (RegL Rsi)
            (RegL R15)))
          ((VarL y.1)
           ((VarL $ea.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL R15)))
          ((RegL Rsp)
           ((VarL $ea.1)
            (VarL $ea.2)
            (VarL $tmp.2)
            (VarL $tmp.3)
            (VarL $tmp.4)
            (VarL _.1)
            (VarL _.2)
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
          ((RegL Rax) ((VarL $ea.1) (RegL Rsp)))
          ((RegL Rcx) ((VarL $ea.1) (RegL Rsp)))
          ((RegL Rdx) ((VarL $ea.1) (RegL Rsp)))
          ((RegL Rsi)
           ((VarL $ea.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL Rdi)))
          ((RegL Rdi)
           ((VarL $ea.1) (RegL Rsp) (RegL Rsi)))
          ((RegL R8) ((VarL $ea.1) (RegL Rsp)))
          ((RegL R9) ((VarL $ea.1) (RegL Rsp)))
          ((RegL R10) ((VarL $ea.1) (RegL Rsp)))
          ((RegL R11)
           ((VarL $ea.1) (VarL $ea.2) (RegL Rsp)))
          ((RegL R15)
           ((VarL $ea.1)
            (VarL $tmp.2)
            (VarL $tmp.3)
            (VarL $tmp.4)
            (VarL x.1)
            (VarL y.1)
            (RegL Rflags)))
          ((RegL Rflags)
           ((VarL $ea.1) (RegL Rsp) (RegL R15))))))
     ((nparams 2)
      (locals
        ((x.1 Integer)
         (y.1 Integer)
         ($ea.1 Integer)
         ($ea.2 (Vector (Integer)))
         ($tmp.2 Integer)
         ($tmp.3 Integer)
         ($tmp.4 Integer)
         (_.1 Unit)
         (_.2 Unit)
         (x.1 Integer)
         (y.1 Integer)))
      (body
        (((Label block_1)
          (Block
            Binfo1
            ((Movq
               (GlobalArg (Label free_ptr))
               (Reg R11))
             (Addq
               (Imm 16)
               (GlobalArg (Label free_ptr)))
             (Movq (Imm 3) (Deref R11 0))
             (Movq (Reg R11) (Var $ea.2))
             (Movq (Var $ea.2) (Reg R11))
             (Movq (Var $ea.1) (Deref R11 8))
             (Movq (Imm 0) (Var _.1))
             (Movq (Var $ea.2) (Reg Rax))
             (Jmp (Label add_conclusion)))))
         ((Label block_2)
          (Block
            Binfo1
            ((Movq (Imm 0) (Var _.2))
             (Jmp (Label block_1)))))
         ((Label block_3)
          (Block
            Binfo1
            ((Movq (Reg R15) (Reg Rdi))
             (Movq (Imm 16) (Reg Rsi))
             (Callq (Label collect) 2)
             (Jmp (Label block_1)))))
         ((Label add_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x.1))
             (Movq (Reg Rsi) (Var y.1))
             (Movq (Var x.1) (Var $ea.1))
             (Addq (Var y.1) (Var $ea.1))
             (Movq
               (GlobalArg (Label free_ptr))
               (Var $tmp.2))
             (Movq (Var $tmp.2) (Var $tmp.3))
             (Addq (Imm 16) (Var $tmp.3))
             (Movq
               (GlobalArg (Label fromspace_end))
               (Var $tmp.4))
             (Cmpq (Var $tmp.4) (Var $tmp.3))
             (JmpIf CC_l (Label block_2))
             (Jmp (Label block_3)))))))))
   (Def
     (Label f)
     (Finfo2
       (conflicts
         (((VarL $ea.3)
           ((VarL _.3)
            (VarL _.4)
            (VarL x.2)
            (VarL y.2)
            (RegL Rsp)
            (RegL R11)))
          ((VarL $tmp.10)
           ((VarL $tmp.11)
            (VarL $tmp.9)
            (VarL z.1)
            (RegL Rsp)))
          ((VarL $tmp.11)
           ((VarL $tmp.10)
            (VarL $tmp.12)
            (VarL z.1)
            (RegL Rsp)
            (RegL R11)))
          ((VarL $tmp.12)
           ((VarL $tmp.11) (RegL Rsp) (RegL Rax)))
          ((VarL $tmp.5)
           ((VarL x.2)
            (VarL y.2)
            (RegL Rsp)
            (RegL R15)))
          ((VarL $tmp.6)
           ((VarL $tmp.7)
            (VarL x.2)
            (VarL y.2)
            (RegL Rsp)
            (RegL R15)))
          ((VarL $tmp.7)
           ((VarL $tmp.6)
            (VarL x.2)
            (VarL y.2)
            (RegL Rsp)
            (RegL R15)))
          ((VarL $tmp.8)
           ((VarL v.1)
            (VarL x.2)
            (VarL y.2)
            (RegL Rsp)
            (RegL Rsi)
            (RegL Rdi)))
          ((VarL $tmp.9)
           ((VarL $tmp.10)
            (VarL v.1)
            (VarL z.1)
            (RegL Rsp)
            (RegL R11)))
          ((VarL _.3)
           ((VarL $ea.3)
            (VarL x.2)
            (VarL y.2)
            (RegL Rsp)))
          ((VarL _.4)
           ((VarL $ea.3)
            (VarL x.2)
            (VarL y.2)
            (RegL Rsp)))
          ((VarL _.5)
           ((VarL x.2) (VarL y.2) (RegL Rsp)))
          ((VarL add) ((RegL Rsp)))
          ((VarL v.1)
           ((VarL $tmp.8)
            (VarL $tmp.9)
            (VarL x.2)
            (VarL y.2)
            (VarL z.1)
            (RegL Rsp)
            (RegL Rax)
            (RegL Rbx)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)
            (RegL R12)
            (RegL R13)
            (RegL R14)))
          ((VarL x.2)
           ((VarL $ea.3)
            (VarL $tmp.5)
            (VarL $tmp.6)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL _.3)
            (VarL _.4)
            (VarL _.5)
            (VarL v.1)
            (VarL y.2)
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
            (RegL R15)
            (RegL Rflags)))
          ((VarL y.2)
           ((VarL $ea.3)
            (VarL $tmp.5)
            (VarL $tmp.6)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL _.3)
            (VarL _.4)
            (VarL _.5)
            (VarL v.1)
            (VarL x.2)
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
            (RegL R15)
            (RegL Rflags)))
          ((VarL z.1)
           ((VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.9)
            (VarL v.1)
            (RegL Rsp)
            (RegL R11)))
          ((RegL Rsp)
           ((VarL $ea.3)
            (VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.12)
            (VarL $tmp.5)
            (VarL $tmp.6)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL $tmp.9)
            (VarL _.3)
            (VarL _.4)
            (VarL _.5)
            (VarL add)
            (VarL v.1)
            (VarL x.2)
            (VarL y.2)
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
           ((VarL $tmp.12)
            (VarL v.1)
            (VarL x.2)
            (VarL y.2)
            (RegL Rsp)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)))
          ((RegL Rbx) ((VarL v.1)))
          ((RegL Rcx)
           ((VarL v.1)
            (VarL x.2)
            (VarL y.2)
            (RegL Rsp)
            (RegL Rax)))
          ((RegL Rdx)
           ((VarL v.1)
            (VarL x.2)
            (VarL y.2)
            (RegL Rsp)
            (RegL Rax)))
          ((RegL Rsi)
           ((VarL $tmp.8)
            (VarL v.1)
            (VarL x.2)
            (VarL y.2)
            (RegL Rsp)
            (RegL Rax)
            (RegL Rdi)))
          ((RegL Rdi)
           ((VarL $tmp.8)
            (VarL v.1)
            (VarL x.2)
            (VarL y.2)
            (RegL Rsp)
            (RegL Rax)
            (RegL Rsi)))
          ((RegL R8)
           ((VarL v.1)
            (VarL x.2)
            (VarL y.2)
            (RegL Rsp)
            (RegL Rax)))
          ((RegL R9)
           ((VarL v.1)
            (VarL x.2)
            (VarL y.2)
            (RegL Rsp)
            (RegL Rax)))
          ((RegL R10)
           ((VarL v.1)
            (VarL x.2)
            (VarL y.2)
            (RegL Rsp)
            (RegL Rax)))
          ((RegL R11)
           ((VarL $ea.3)
            (VarL $tmp.11)
            (VarL $tmp.9)
            (VarL v.1)
            (VarL x.2)
            (VarL y.2)
            (VarL z.1)
            (RegL Rsp)
            (RegL Rax)))
          ((RegL R12) ((VarL v.1)))
          ((RegL R13) ((VarL v.1)))
          ((RegL R14) ((VarL v.1)))
          ((RegL R15)
           ((VarL $tmp.5)
            (VarL $tmp.6)
            (VarL $tmp.7)
            (VarL x.2)
            (VarL y.2)
            (RegL Rflags)))
          ((RegL Rflags)
           ((VarL x.2)
            (VarL y.2)
            (RegL Rsp)
            (RegL R15))))))
     ((nparams 2)
      (locals
        ((x.2 Integer)
         (y.2 Integer)
         ($ea.3 (Vector (Integer Integer)))
         ($tmp.10 Integer)
         ($tmp.11 Integer)
         ($tmp.12 Integer)
         ($tmp.5 Integer)
         ($tmp.6 Integer)
         ($tmp.7 Integer)
         ($tmp.8
           (Function
             (Integer Integer)
             (Vector (Integer))))
         ($tmp.9 Integer)
         (_.3 Unit)
         (_.4 Unit)
         (_.5 Unit)
         (add
           (Function
             (Integer Integer)
             (Vector (Integer))))
         (v.1 (Vector (Integer Integer)))
         (x.2 Integer)
         (y.2 Integer)
         (z.1 (Vector (Integer)))))
      (body
        (((Label block_4)
          (Block
            Binfo1
            ((Movq
               (GlobalArg (Label free_ptr))
               (Reg R11))
             (Addq
               (Imm 24)
               (GlobalArg (Label free_ptr)))
             (Movq (Imm 5) (Deref R11 0))
             (Movq (Reg R11) (Var $ea.3))
             (Movq (Var $ea.3) (Reg R11))
             (Movq (Var x.2) (Deref R11 8))
             (Movq (Imm 0) (Var _.4))
             (Movq (Var $ea.3) (Reg R11))
             (Movq (Var y.2) (Deref R11 16))
             (Movq (Imm 0) (Var _.3))
             (Movq (Var $ea.3) (Var v.1))
             (Leaq
               (GlobalArg (Label add))
               (Var $tmp.8))
             (Movq (Var x.2) (Reg Rdi))
             (Movq (Var y.2) (Reg Rsi))
             (IndirectCallq (Var $tmp.8) 2)
             (Movq (Reg Rax) (Var z.1))
             (Movq (Var v.1) (Reg R11))
             (Movq (Deref R11 8) (Var $tmp.9))
             (Movq (Var v.1) (Reg R11))
             (Movq (Deref R11 16) (Var $tmp.10))
             (Movq (Var $tmp.9) (Var $tmp.11))
             (Addq (Var $tmp.10) (Var $tmp.11))
             (Movq (Var z.1) (Reg R11))
             (Movq (Deref R11 8) (Var $tmp.12))
             (Movq (Var $tmp.11) (Reg Rax))
             (Addq (Var $tmp.12) (Reg Rax))
             (Jmp (Label f_conclusion)))))
         ((Label block_5)
          (Block
            Binfo1
            ((Movq (Imm 0) (Var _.5))
             (Jmp (Label block_4)))))
         ((Label block_6)
          (Block
            Binfo1
            ((Movq (Reg R15) (Reg Rdi))
             (Movq (Imm 24) (Reg Rsi))
             (Callq (Label collect) 2)
             (Jmp (Label block_4)))))
         ((Label f_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x.2))
             (Movq (Reg Rsi) (Var y.2))
             (Movq
               (GlobalArg (Label free_ptr))
               (Var $tmp.5))
             (Movq (Var $tmp.5) (Var $tmp.6))
             (Addq (Imm 24) (Var $tmp.6))
             (Movq
               (GlobalArg (Label fromspace_end))
               (Var $tmp.7))
             (Cmpq (Var $tmp.7) (Var $tmp.6))
             (JmpIf CC_l (Label block_5))
             (Jmp (Label block_6)))))))))))
