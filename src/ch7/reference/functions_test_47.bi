(X86Program
  ((Def
     (Label main)
     (Finfo2
       (conflicts
         (((VarL $tmp.1) ((RegL Rsp) (RegL Rdi)))
          ((VarL $tmp.2) ((RegL Rsp)))
          ((VarL sum) ((RegL Rsp)))
          ((RegL Rsp)
           ((VarL $tmp.1)
            (VarL $tmp.2)
            (VarL sum)
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
          ((RegL Rdi)
           ((VarL $tmp.1) (RegL Rsp) (RegL Rax)))
          ((RegL R8) ((RegL Rsp) (RegL Rax)))
          ((RegL R9) ((RegL Rsp) (RegL Rax)))
          ((RegL R10) ((RegL Rsp) (RegL Rax)))
          ((RegL R11) ((RegL Rsp) (RegL Rax)))
          ((RegL Rflags) ((RegL Rsp))))))
     ((nparams 0)
      (locals
        (($tmp.1 (Function (Integer) Integer))
         ($tmp.2 Integer)
         (sum (Function (Integer) Integer))))
      (body
        (((Label block_1)
          (Block
            Binfo1
            ((Movq (Imm 42) (Reg Rax))
             (Jmp (Label main_conclusion)))))
         ((Label block_2)
          (Block
            Binfo1
            ((Movq (Imm 777) (Reg Rax))
             (Jmp (Label main_conclusion)))))
         ((Label main_start)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label sum))
               (Var $tmp.1))
             (Movq (Imm 3) (Reg Rdi))
             (IndirectCallq (Var $tmp.1) 1)
             (Movq (Reg Rax) (Var $tmp.2))
             (Cmpq (Imm 6) (Var $tmp.2))
             (JmpIf CC_e (Label block_1))
             (Jmp (Label block_2)))))))))
   (Def
     (Label sum)
     (Finfo2
       (conflicts
         (((VarL $ea.1)
           ((VarL _.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL R11)
            (RegL R15)))
          ((VarL $ea.2)
           ((VarL _.3)
            (VarL x-vec.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL R11)
            (RegL R15)))
          ((VarL $ea.3)
           ((VarL $ea.4)
            (VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.9)
            (VarL _.6)
            (VarL one.1)
            (VarL x-vec.1)
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
            (RegL R15)
            (RegL Rflags)))
          ((VarL $ea.4)
           ((VarL $ea.3)
            (VarL _.5)
            (VarL one.1)
            (VarL x-vec.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL R11)))
          ((VarL $tmp.10)
           ((VarL $ea.3)
            (VarL $tmp.11)
            (VarL one.1)
            (VarL x-vec.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL R15)))
          ((VarL $tmp.11)
           ((VarL $ea.3)
            (VarL $tmp.10)
            (VarL one.1)
            (VarL x-vec.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL R15)))
          ((VarL $tmp.12)
           ((VarL neg-one.1)
            (VarL one.1)
            (VarL x.1)
            (RegL Rsp)))
          ((VarL $tmp.13)
           ((VarL $tmp.14)
            (VarL $tmp.15)
            (VarL x.1)
            (RegL Rsp)))
          ((VarL $tmp.14)
           ((VarL $tmp.13)
            (VarL $tmp.15)
            (VarL x.1)
            (RegL Rsp)))
          ((VarL $tmp.15)
           ((VarL $tmp.13)
            (VarL $tmp.14)
            (VarL neg-one.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL Rdi)
            (RegL R11)))
          ((VarL $tmp.16)
           ((VarL x.1) (RegL Rsp) (RegL Rax)))
          ((VarL $tmp.3)
           ((VarL x.1) (RegL Rsp) (RegL R15)))
          ((VarL $tmp.4)
           ((VarL $tmp.5)
            (VarL x.1)
            (RegL Rsp)
            (RegL R15)))
          ((VarL $tmp.5)
           ((VarL $tmp.4)
            (VarL x.1)
            (RegL Rsp)
            (RegL R15)))
          ((VarL $tmp.6)
           ((VarL x-vec.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL R15)))
          ((VarL $tmp.7)
           ((VarL $tmp.8)
            (VarL x-vec.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL R15)))
          ((VarL $tmp.8)
           ((VarL $tmp.7)
            (VarL x-vec.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL R15)))
          ((VarL $tmp.9)
           ((VarL $ea.3)
            (VarL one.1)
            (VarL x-vec.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL R15)))
          ((VarL _.1)
           ((VarL $ea.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL R15)))
          ((VarL _.2)
           ((VarL x.1) (RegL Rsp) (RegL R15)))
          ((VarL _.3)
           ((VarL $ea.2)
            (VarL x-vec.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL R15)))
          ((VarL _.4)
           ((VarL x-vec.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL R15)))
          ((VarL _.5)
           ((VarL $ea.4)
            (VarL one.1)
            (VarL x-vec.1)
            (VarL x.1)
            (RegL Rsp)))
          ((VarL _.6)
           ((VarL $ea.3)
            (VarL one.1)
            (VarL x-vec.1)
            (VarL x.1)
            (RegL Rsp)))
          ((VarL neg-one.1)
           ((VarL $tmp.12)
            (VarL $tmp.15)
            (VarL one.1)
            (VarL x-vec.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL R11)
            (RegL Rflags)))
          ((VarL one.1)
           ((VarL $ea.3)
            (VarL $ea.4)
            (VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.12)
            (VarL $tmp.9)
            (VarL _.5)
            (VarL _.6)
            (VarL neg-one.1)
            (VarL x-vec.1)
            (VarL x.1)
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
            (RegL R14)
            (RegL R15)
            (RegL Rflags)))
          ((VarL sum) ((RegL Rsp)))
          ((VarL x-vec.1)
           ((VarL $ea.2)
            (VarL $ea.3)
            (VarL $ea.4)
            (VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.6)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL $tmp.9)
            (VarL _.3)
            (VarL _.4)
            (VarL _.5)
            (VarL _.6)
            (VarL neg-one.1)
            (VarL one.1)
            (VarL x.1)
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
            (RegL R14)
            (RegL R15)
            (RegL Rflags)))
          ((VarL x.1)
           ((VarL $ea.1)
            (VarL $ea.2)
            (VarL $ea.3)
            (VarL $ea.4)
            (VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.12)
            (VarL $tmp.13)
            (VarL $tmp.14)
            (VarL $tmp.15)
            (VarL $tmp.16)
            (VarL $tmp.3)
            (VarL $tmp.4)
            (VarL $tmp.5)
            (VarL $tmp.6)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL $tmp.9)
            (VarL _.1)
            (VarL _.2)
            (VarL _.3)
            (VarL _.4)
            (VarL _.5)
            (VarL _.6)
            (VarL neg-one.1)
            (VarL one.1)
            (VarL x-vec.1)
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
          ((RegL Rsp)
           ((VarL $ea.1)
            (VarL $ea.2)
            (VarL $ea.3)
            (VarL $ea.4)
            (VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.12)
            (VarL $tmp.13)
            (VarL $tmp.14)
            (VarL $tmp.15)
            (VarL $tmp.16)
            (VarL $tmp.3)
            (VarL $tmp.4)
            (VarL $tmp.5)
            (VarL $tmp.6)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL $tmp.9)
            (VarL _.1)
            (VarL _.2)
            (VarL _.3)
            (VarL _.4)
            (VarL _.5)
            (VarL _.6)
            (VarL neg-one.1)
            (VarL one.1)
            (VarL sum)
            (VarL x-vec.1)
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
           ((VarL $ea.3)
            (VarL $tmp.16)
            (VarL one.1)
            (VarL x-vec.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL Rcx)
            (RegL Rdx)
            (RegL Rsi)
            (RegL Rdi)
            (RegL R8)
            (RegL R9)
            (RegL R10)
            (RegL R11)
            (RegL R15)))
          ((RegL Rbx)
           ((VarL one.1) (VarL x-vec.1)))
          ((RegL Rcx)
           ((VarL $ea.3)
            (VarL one.1)
            (VarL x-vec.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL Rax)
            (RegL R15)))
          ((RegL Rdx)
           ((VarL $ea.3)
            (VarL one.1)
            (VarL x-vec.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL Rax)
            (RegL R15)))
          ((RegL Rsi)
           ((VarL $ea.3)
            (VarL one.1)
            (VarL x-vec.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL Rax)
            (RegL Rdi)
            (RegL R15)))
          ((RegL Rdi)
           ((VarL $ea.3)
            (VarL $tmp.15)
            (VarL one.1)
            (VarL x-vec.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL Rax)
            (RegL Rsi)
            (RegL R15)))
          ((RegL R8)
           ((VarL $ea.3)
            (VarL one.1)
            (VarL x-vec.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL Rax)
            (RegL R15)))
          ((RegL R9)
           ((VarL $ea.3)
            (VarL one.1)
            (VarL x-vec.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL Rax)
            (RegL R15)))
          ((RegL R10)
           ((VarL $ea.3)
            (VarL one.1)
            (VarL x-vec.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL Rax)
            (RegL R15)))
          ((RegL R11)
           ((VarL $ea.1)
            (VarL $ea.2)
            (VarL $ea.3)
            (VarL $ea.4)
            (VarL $tmp.15)
            (VarL neg-one.1)
            (VarL one.1)
            (VarL x-vec.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL Rax)
            (RegL R15)))
          ((RegL R12)
           ((VarL one.1) (VarL x-vec.1)))
          ((RegL R13)
           ((VarL one.1) (VarL x-vec.1)))
          ((RegL R14)
           ((VarL one.1) (VarL x-vec.1)))
          ((RegL R15)
           ((VarL $ea.1)
            (VarL $ea.2)
            (VarL $ea.3)
            (VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.3)
            (VarL $tmp.4)
            (VarL $tmp.5)
            (VarL $tmp.6)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL $tmp.9)
            (VarL _.1)
            (VarL _.2)
            (VarL _.3)
            (VarL _.4)
            (VarL one.1)
            (VarL x-vec.1)
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
          ((RegL Rflags)
           ((VarL $ea.3)
            (VarL neg-one.1)
            (VarL one.1)
            (VarL x-vec.1)
            (VarL x.1)
            (RegL Rsp)
            (RegL R15))))))
     ((nparams 1)
      (locals
        ((x.1 Integer)
         ($ea.1 (Vector (Integer)))
         ($ea.2 (Vector (Integer)))
         ($ea.3 Integer)
         ($ea.4 (Vector (Integer)))
         ($tmp.10 Integer)
         ($tmp.11 Integer)
         ($tmp.12 Integer)
         ($tmp.13 Integer)
         ($tmp.14 Integer)
         ($tmp.15 (Function (Integer) Integer))
         ($tmp.16 Integer)
         ($tmp.3 Integer)
         ($tmp.4 Integer)
         ($tmp.5 Integer)
         ($tmp.6 Integer)
         ($tmp.7 Integer)
         ($tmp.8 Integer)
         ($tmp.9 Integer)
         (_.1 Unit)
         (_.2 Unit)
         (_.3 Unit)
         (_.4 Unit)
         (_.5 Unit)
         (_.6 Unit)
         (neg-one.1 (Vector (Integer)))
         (one.1 (Vector (Integer)))
         (sum (Function (Integer) Integer))
         (x-vec.1 (Vector (Integer)))
         (x.1 Integer)))
      (body
        (((Label block_10)
          (Block
            Binfo1
            ((Movq (Reg R15) (Reg Rdi))
             (Movq (Imm 16) (Reg Rsi))
             (Callq (Label collect) 2)
             (Jmp (Label block_8)))))
         ((Label block_11)
          (Block
            Binfo1
            ((Movq
               (GlobalArg (Label free_ptr))
               (Reg R11))
             (Addq
               (Imm 16)
               (GlobalArg (Label free_ptr)))
             (Movq (Imm 3) (Deref R11 0))
             (Movq (Reg R11) (Var $ea.1))
             (Movq (Var $ea.1) (Reg R11))
             (Movq (Var x.1) (Deref R11 8))
             (Movq (Imm 0) (Var _.1))
             (Movq (Var $ea.1) (Var x-vec.1))
             (Movq
               (GlobalArg (Label free_ptr))
               (Var $tmp.6))
             (Movq (Var $tmp.6) (Var $tmp.7))
             (Addq (Imm 16) (Var $tmp.7))
             (Movq
               (GlobalArg (Label fromspace_end))
               (Var $tmp.8))
             (Cmpq (Var $tmp.8) (Var $tmp.7))
             (JmpIf CC_l (Label block_9))
             (Jmp (Label block_10)))))
         ((Label block_12)
          (Block
            Binfo1
            ((Movq (Imm 0) (Var _.2))
             (Jmp (Label block_11)))))
         ((Label block_13)
          (Block
            Binfo1
            ((Movq (Reg R15) (Reg Rdi))
             (Movq (Imm 16) (Reg Rsi))
             (Callq (Label collect) 2)
             (Jmp (Label block_11)))))
         ((Label block_3)
          (Block
            Binfo1
            ((Movq (Var one.1) (Reg R11))
             (Movq (Deref R11 8) (Reg Rax))
             (Jmp (Label sum_conclusion)))))
         ((Label block_4)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label sum))
               (Var $tmp.15))
             (Movq (Var neg-one.1) (Reg R11))
             (Movq (Deref R11 8) (Var $tmp.13))
             (Movq (Var x.1) (Var $tmp.14))
             (Addq (Var $tmp.13) (Var $tmp.14))
             (Movq (Var $tmp.14) (Reg Rdi))
             (IndirectCallq (Var $tmp.15) 1)
             (Movq (Reg Rax) (Var $tmp.16))
             (Movq (Var x.1) (Reg Rax))
             (Addq (Var $tmp.16) (Reg Rax))
             (Jmp (Label sum_conclusion)))))
         ((Label block_5)
          (Block
            Binfo1
            ((Movq
               (GlobalArg (Label free_ptr))
               (Reg R11))
             (Addq
               (Imm 16)
               (GlobalArg (Label free_ptr)))
             (Movq (Imm 3) (Deref R11 0))
             (Movq (Reg R11) (Var $ea.4))
             (Movq (Var $ea.4) (Reg R11))
             (Movq (Var $ea.3) (Deref R11 8))
             (Movq (Imm 0) (Var _.5))
             (Movq (Var $ea.4) (Var neg-one.1))
             (Movq (Var x-vec.1) (Reg R11))
             (Movq (Deref R11 8) (Var $tmp.12))
             (Cmpq (Imm 1) (Var $tmp.12))
             (JmpIf CC_e (Label block_3))
             (Jmp (Label block_4)))))
         ((Label block_6)
          (Block
            Binfo1
            ((Movq (Imm 0) (Var _.6))
             (Jmp (Label block_5)))))
         ((Label block_7)
          (Block
            Binfo1
            ((Movq (Reg R15) (Reg Rdi))
             (Movq (Imm 16) (Reg Rsi))
             (Callq (Label collect) 2)
             (Jmp (Label block_5)))))
         ((Label block_8)
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
             (Movq (Imm 1) (Deref R11 8))
             (Movq (Imm 0) (Var _.3))
             (Movq (Var $ea.2) (Var one.1))
             (Movq (Imm 1) (Var $ea.3))
             (Negq (Var $ea.3))
             (Movq
               (GlobalArg (Label free_ptr))
               (Var $tmp.9))
             (Movq (Var $tmp.9) (Var $tmp.10))
             (Addq (Imm 16) (Var $tmp.10))
             (Movq
               (GlobalArg (Label fromspace_end))
               (Var $tmp.11))
             (Cmpq (Var $tmp.11) (Var $tmp.10))
             (JmpIf CC_l (Label block_6))
             (Jmp (Label block_7)))))
         ((Label block_9)
          (Block
            Binfo1
            ((Movq (Imm 0) (Var _.4))
             (Jmp (Label block_8)))))
         ((Label sum_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x.1))
             (Movq
               (GlobalArg (Label free_ptr))
               (Var $tmp.3))
             (Movq (Var $tmp.3) (Var $tmp.4))
             (Addq (Imm 16) (Var $tmp.4))
             (Movq
               (GlobalArg (Label fromspace_end))
               (Var $tmp.5))
             (Cmpq (Var $tmp.5) (Var $tmp.4))
             (JmpIf CC_l (Label block_12))
             (Jmp (Label block_13)))))))))))
