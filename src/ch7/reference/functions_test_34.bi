(X86Program
  ((Def
     (Label main)
     (Finfo2
       (conflicts
         (((VarL $ea.1)
           ((VarL $ea.2)
            (VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.3)
            (VarL _.2)
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
          ((VarL $tmp.1)
           ((VarL $ea.1) (RegL Rsp) (RegL R15)))
          ((VarL $tmp.2)
           ((VarL $ea.1)
            (VarL $tmp.3)
            (RegL Rsp)
            (RegL R15)))
          ((VarL $tmp.3)
           ((VarL $ea.1)
            (VarL $tmp.2)
            (RegL Rsp)
            (RegL R15)))
          ((VarL $tmp.4)
           ((VarL vec.1) (RegL Rsp) (RegL R11)))
          ((VarL $tmp.5) ((RegL Rsp) (RegL Rdi)))
          ((VarL _.1) ((VarL $ea.2) (RegL Rsp)))
          ((VarL _.2) ((VarL $ea.1) (RegL Rsp)))
          ((VarL apply_1) ((RegL Rsp)))
          ((VarL dummy.1)
           ((VarL vec.1) (RegL Rsp)))
          ((VarL even?) ((RegL Rsp)))
          ((VarL odd?) ((RegL Rsp)))
          ((VarL vec.1)
           ((VarL $tmp.4)
            (VarL dummy.1)
            (RegL Rsp)
            (RegL R11)))
          ((RegL Rsp)
           ((VarL $ea.1)
            (VarL $ea.2)
            (VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.3)
            (VarL $tmp.4)
            (VarL $tmp.5)
            (VarL _.1)
            (VarL _.2)
            (VarL apply_1)
            (VarL dummy.1)
            (VarL even?)
            (VarL odd?)
            (VarL vec.1)
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
           ((VarL $ea.1)
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
           ((VarL $ea.1) (RegL Rsp) (RegL Rax)))
          ((RegL Rdx)
           ((VarL $ea.1) (RegL Rsp) (RegL Rax)))
          ((RegL Rsi)
           ((VarL $ea.1)
            (RegL Rsp)
            (RegL Rax)
            (RegL Rdi)))
          ((RegL Rdi)
           ((VarL $ea.1)
            (VarL $tmp.5)
            (RegL Rsp)
            (RegL Rax)
            (RegL Rsi)))
          ((RegL R8)
           ((VarL $ea.1) (RegL Rsp) (RegL Rax)))
          ((RegL R9)
           ((VarL $ea.1) (RegL Rsp) (RegL Rax)))
          ((RegL R10)
           ((VarL $ea.1) (RegL Rsp) (RegL Rax)))
          ((RegL R11)
           ((VarL $ea.1)
            (VarL $ea.2)
            (VarL $tmp.4)
            (VarL vec.1)
            (RegL Rsp)
            (RegL Rax)))
          ((RegL R15)
           ((VarL $ea.1)
            (VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.3)
            (RegL Rflags)))
          ((RegL Rflags)
           ((VarL $ea.1) (RegL Rsp) (RegL R15))))))
     ((nparams 0)
      (locals
        (($ea.1 (Function (Integer) Boolean))
         ($ea.2
           (Vector ((Function (Integer) Boolean))))
         ($tmp.1 Integer)
         ($tmp.2 Integer)
         ($tmp.3 Integer)
         ($tmp.4 (Function (Integer) Boolean))
         ($tmp.5 (Function (Integer) Boolean))
         (_.1 Unit)
         (_.2 Unit)
         (apply_1 Boolean)
         (dummy.1 Unit)
         (even? (Function (Integer) Boolean))
         (odd? (Function (Integer) Boolean))
         (vec.1
           (Vector ((Function (Integer) Boolean))))))
      (body
        (((Label block_1)
          (Block
            Binfo1
            ((Movq (Imm 999) (Reg Rax))
             (Jmp (Label main_conclusion)))))
         ((Label block_2)
          (Block
            Binfo1
            ((Movq (Imm 42) (Reg Rax))
             (Jmp (Label main_conclusion)))))
         ((Label block_3)
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
             (Movq (Var $ea.2) (Var vec.1))
             (Leaq
               (GlobalArg (Label even?))
               (Var $tmp.4))
             (Movq (Var vec.1) (Reg R11))
             (Movq (Var $tmp.4) (Deref R11 8))
             (Movq (Imm 0) (Var dummy.1))
             (Movq (Var vec.1) (Reg R11))
             (Movq (Deref R11 8) (Var $tmp.5))
             (Movq (Imm 21) (Reg Rdi))
             (IndirectCallq (Var $tmp.5) 1)
             (Movq (Reg Rax) (Var apply_1))
             (Cmpq (Imm 1) (Var apply_1))
             (JmpIf CC_e (Label block_1))
             (Jmp (Label block_2)))))
         ((Label block_4)
          (Block
            Binfo1
            ((Movq (Imm 0) (Var _.2))
             (Jmp (Label block_3)))))
         ((Label block_5)
          (Block
            Binfo1
            ((Movq (Reg R15) (Reg Rdi))
             (Movq (Imm 16) (Reg Rsi))
             (Callq (Label collect) 2)
             (Jmp (Label block_3)))))
         ((Label main_start)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label odd?))
               (Var $ea.1))
             (Movq
               (GlobalArg (Label free_ptr))
               (Var $tmp.1))
             (Movq (Var $tmp.1) (Var $tmp.2))
             (Addq (Imm 16) (Var $tmp.2))
             (Movq
               (GlobalArg (Label fromspace_end))
               (Var $tmp.3))
             (Cmpq (Var $tmp.3) (Var $tmp.2))
             (JmpIf CC_l (Label block_4))
             (Jmp (Label block_5)))))))))
   (Def
     (Label even?)
     (Finfo2
       (conflicts
         (((VarL $tmp.6)
           ((VarL $tmp.8) (VarL x.1)))
          ((VarL $tmp.7)
           ((VarL $tmp.8) (VarL x.1)))
          ((VarL $tmp.8)
           ((VarL $tmp.6)
            (VarL $tmp.7)
            (VarL x.1)
            (RegL Rdi)))
          ((VarL odd?) ((RegL Rsp)))
          ((VarL x.1)
           ((VarL $tmp.6)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (RegL Rsp)
            (RegL Rflags)))
          ((RegL Rsp)
           ((VarL odd?)
            (VarL x.1)
            (RegL Rax)
            (RegL Rflags)))
          ((RegL Rax) ((RegL Rsp)))
          ((RegL Rdi) ((VarL $tmp.8)))
          ((RegL Rflags) ((VarL x.1) (RegL Rsp))))))
     ((nparams 1)
      (locals
        ((x.1 Integer)
         ($tmp.6 Integer)
         ($tmp.7 Integer)
         ($tmp.8 (Function (Integer) Boolean))
         (odd? (Function (Integer) Boolean))
         (x.1 Integer)))
      (body
        (((Label block_6)
          (Block
            Binfo1
            ((Movq (Imm 1) (Reg Rax))
             (Jmp (Label even?_conclusion)))))
         ((Label block_7)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label odd?))
               (Var $tmp.8))
             (Movq (Imm 1) (Var $tmp.6))
             (Negq (Var $tmp.6))
             (Movq (Var $tmp.6) (Var $tmp.7))
             (Addq (Var x.1) (Var $tmp.7))
             (Movq (Var $tmp.7) (Reg Rdi))
             (TailJmp (Var $tmp.8) 1))))
         ((Label even?_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x.1))
             (Cmpq (Imm 0) (Var x.1))
             (JmpIf CC_e (Label block_6))
             (Jmp (Label block_7)))))))))
   (Def
     (Label odd?)
     (Finfo2
       (conflicts
         (((VarL $tmp.10)
           ((VarL $tmp.11) (VarL x.2)))
          ((VarL $tmp.11)
           ((VarL $tmp.10)
            (VarL $tmp.9)
            (VarL x.2)
            (RegL Rdi)))
          ((VarL $tmp.9)
           ((VarL $tmp.11) (VarL x.2)))
          ((VarL even?) ((RegL Rsp)))
          ((VarL x.2)
           ((VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.9)
            (RegL Rsp)
            (RegL Rflags)))
          ((RegL Rsp)
           ((VarL even?)
            (VarL x.2)
            (RegL Rax)
            (RegL Rflags)))
          ((RegL Rax) ((RegL Rsp)))
          ((RegL Rdi) ((VarL $tmp.11)))
          ((RegL Rflags) ((VarL x.2) (RegL Rsp))))))
     ((nparams 1)
      (locals
        ((x.2 Integer)
         ($tmp.10 Integer)
         ($tmp.11 (Function (Integer) Boolean))
         ($tmp.9 Integer)
         (even? (Function (Integer) Boolean))
         (x.2 Integer)))
      (body
        (((Label block_8)
          (Block
            Binfo1
            ((Movq (Imm 0) (Reg Rax))
             (Jmp (Label odd?_conclusion)))))
         ((Label block_9)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label even?))
               (Var $tmp.11))
             (Movq (Imm 1) (Var $tmp.9))
             (Negq (Var $tmp.9))
             (Movq (Var $tmp.9) (Var $tmp.10))
             (Addq (Var x.2) (Var $tmp.10))
             (Movq (Var $tmp.10) (Reg Rdi))
             (TailJmp (Var $tmp.11) 1))))
         ((Label odd?_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x.2))
             (Cmpq (Imm 0) (Var x.2))
             (JmpIf CC_e (Label block_8))
             (Jmp (Label block_9)))))))))))
