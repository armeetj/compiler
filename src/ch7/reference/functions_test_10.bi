(X86Program
  ((Def
     (Label main)
     (Finfo2
       (conflicts
         (((VarL $ea.1)
           ((VarL $tmp.1)
            (VarL $tmp.5)
            (VarL _.1)
            (VarL _.2)
            (RegL Rsp)
            (RegL Rdi)
            (RegL R11)))
          ((VarL $tmp.1)
           ((VarL $ea.1)
            (VarL $tmp.2)
            (VarL $tmp.3)
            (VarL $tmp.4)
            (VarL $tmp.5)
            (VarL _.1)
            (VarL _.2)
            (VarL _.3)
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
          ((VarL $tmp.2)
           ((VarL $tmp.1)
            (VarL $tmp.5)
            (RegL Rsp)
            (RegL R15)))
          ((VarL $tmp.3)
           ((VarL $tmp.1)
            (VarL $tmp.4)
            (VarL $tmp.5)
            (RegL Rsp)
            (RegL R15)))
          ((VarL $tmp.4)
           ((VarL $tmp.1)
            (VarL $tmp.3)
            (VarL $tmp.5)
            (RegL Rsp)
            (RegL R15)))
          ((VarL $tmp.5)
           ((VarL $ea.1)
            (VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.3)
            (VarL $tmp.4)
            (VarL _.1)
            (VarL _.2)
            (VarL _.3)
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
          ((VarL $tmp.6) ((RegL Rsp)))
          ((VarL _.1)
           ((VarL $ea.1)
            (VarL $tmp.1)
            (VarL $tmp.5)
            (RegL Rsp)))
          ((VarL _.2)
           ((VarL $ea.1)
            (VarL $tmp.1)
            (VarL $tmp.5)
            (RegL Rsp)))
          ((VarL _.3)
           ((VarL $tmp.1) (VarL $tmp.5) (RegL Rsp)))
          ((VarL add1) ((RegL Rsp)))
          ((VarL map_vec) ((RegL Rsp)))
          ((RegL Rsp)
           ((VarL $ea.1)
            (VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.3)
            (VarL $tmp.4)
            (VarL $tmp.5)
            (VarL $tmp.6)
            (VarL _.1)
            (VarL _.2)
            (VarL _.3)
            (VarL add1)
            (VarL map_vec)
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
            (VarL $tmp.5)
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
           ((VarL $tmp.1)
            (VarL $tmp.5)
            (RegL Rsp)
            (RegL Rax)))
          ((RegL Rdx)
           ((VarL $tmp.1)
            (VarL $tmp.5)
            (RegL Rsp)
            (RegL Rax)))
          ((RegL Rsi)
           ((VarL $tmp.1)
            (VarL $tmp.5)
            (RegL Rsp)
            (RegL Rax)
            (RegL Rdi)))
          ((RegL Rdi)
           ((VarL $ea.1)
            (VarL $tmp.1)
            (VarL $tmp.5)
            (RegL Rsp)
            (RegL Rax)
            (RegL Rsi)))
          ((RegL R8)
           ((VarL $tmp.1)
            (VarL $tmp.5)
            (RegL Rsp)
            (RegL Rax)))
          ((RegL R9)
           ((VarL $tmp.1)
            (VarL $tmp.5)
            (RegL Rsp)
            (RegL Rax)))
          ((RegL R10)
           ((VarL $tmp.1)
            (VarL $tmp.5)
            (RegL Rsp)
            (RegL Rax)))
          ((RegL R11)
           ((VarL $ea.1)
            (VarL $tmp.1)
            (VarL $tmp.5)
            (RegL Rsp)
            (RegL Rax)))
          ((RegL R15)
           ((VarL $tmp.1)
            (VarL $tmp.2)
            (VarL $tmp.3)
            (VarL $tmp.4)
            (VarL $tmp.5)
            (RegL Rflags)))
          ((RegL Rflags)
           ((VarL $tmp.1)
            (VarL $tmp.5)
            (RegL Rsp)
            (RegL R15))))))
     ((nparams 0)
      (locals
        (($ea.1 (Vector (Integer Integer)))
         ($tmp.1 (Function (Integer) Integer))
         ($tmp.2 Integer)
         ($tmp.3 Integer)
         ($tmp.4 Integer)
         ($tmp.5
           (Function
             ((Function (Integer) Integer)
              (Vector (Integer Integer)))
             (Vector (Integer Integer))))
         ($tmp.6 (Vector (Integer Integer)))
         (_.1 Unit)
         (_.2 Unit)
         (_.3 Unit)
         (add1 (Function (Integer) Integer))
         (map_vec
           (Function
             ((Function (Integer) Integer)
              (Vector (Integer Integer)))
             (Vector (Integer Integer))))))
      (body
        (((Label block_1)
          (Block
            Binfo1
            ((Movq
               (GlobalArg (Label free_ptr))
               (Reg R11))
             (Addq
               (Imm 24)
               (GlobalArg (Label free_ptr)))
             (Movq (Imm 5) (Deref R11 0))
             (Movq (Reg R11) (Var $ea.1))
             (Movq (Var $ea.1) (Reg R11))
             (Movq (Imm 0) (Deref R11 8))
             (Movq (Imm 0) (Var _.2))
             (Movq (Var $ea.1) (Reg R11))
             (Movq (Imm 41) (Deref R11 16))
             (Movq (Imm 0) (Var _.1))
             (Movq (Var $tmp.1) (Reg Rdi))
             (Movq (Var $ea.1) (Reg Rsi))
             (IndirectCallq (Var $tmp.5) 2)
             (Movq (Reg Rax) (Var $tmp.6))
             (Movq (Var $tmp.6) (Reg R11))
             (Movq (Deref R11 16) (Reg Rax))
             (Jmp (Label main_conclusion)))))
         ((Label block_2)
          (Block
            Binfo1
            ((Movq (Imm 0) (Var _.3))
             (Jmp (Label block_1)))))
         ((Label block_3)
          (Block
            Binfo1
            ((Movq (Reg R15) (Reg Rdi))
             (Movq (Imm 24) (Reg Rsi))
             (Callq (Label collect) 2)
             (Jmp (Label block_1)))))
         ((Label main_start)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label map_vec))
               (Var $tmp.5))
             (Leaq
               (GlobalArg (Label add1))
               (Var $tmp.1))
             (Movq
               (GlobalArg (Label free_ptr))
               (Var $tmp.2))
             (Movq (Var $tmp.2) (Var $tmp.3))
             (Addq (Imm 24) (Var $tmp.3))
             (Movq
               (GlobalArg (Label fromspace_end))
               (Var $tmp.4))
             (Cmpq (Var $tmp.4) (Var $tmp.3))
             (JmpIf CC_l (Label block_2))
             (Jmp (Label block_3)))))))))
   (Def
     (Label map_vec)
     (Finfo2
       (conflicts
         (((VarL $ea.2)
           ((VarL $ea.3)
            (VarL $ea.4)
            (VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.8)
            (VarL $tmp.9)
            (VarL _.6)
            (VarL f.1)
            (VarL v.1)
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
          ((VarL $ea.3)
           ((VarL $ea.2)
            (VarL $ea.4)
            (VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.9)
            (VarL _.5)
            (VarL _.6)
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
           ((VarL $ea.2)
            (VarL $ea.3)
            (VarL _.4)
            (VarL _.5)
            (RegL Rsp)
            (RegL R11)))
          ((VarL $tmp.10)
           ((VarL $ea.2)
            (VarL $ea.3)
            (VarL $tmp.11)
            (RegL Rsp)
            (RegL R15)))
          ((VarL $tmp.11)
           ((VarL $ea.2)
            (VarL $ea.3)
            (VarL $tmp.10)
            (RegL Rsp)
            (RegL R15)))
          ((VarL $tmp.7)
           ((VarL f.1)
            (VarL v.1)
            (RegL Rsp)
            (RegL R15)))
          ((VarL $tmp.8)
           ((VarL $ea.2)
            (VarL f.1)
            (RegL Rsp)
            (RegL R15)))
          ((VarL $tmp.9)
           ((VarL $ea.2)
            (VarL $ea.3)
            (RegL Rsp)
            (RegL R15)))
          ((VarL _.4) ((VarL $ea.4) (RegL Rsp)))
          ((VarL _.5)
           ((VarL $ea.3) (VarL $ea.4) (RegL Rsp)))
          ((VarL _.6)
           ((VarL $ea.2) (VarL $ea.3) (RegL Rsp)))
          ((VarL f.1)
           ((VarL $ea.2)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL v.1)
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
            (RegL R15)))
          ((VarL v.1)
           ((VarL $ea.2)
            (VarL $tmp.7)
            (VarL f.1)
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
            (RegL R15)))
          ((RegL Rsp)
           ((VarL $ea.2)
            (VarL $ea.3)
            (VarL $ea.4)
            (VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL $tmp.9)
            (VarL _.4)
            (VarL _.5)
            (VarL _.6)
            (VarL f.1)
            (VarL v.1)
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
           ((VarL $ea.2)
            (VarL $ea.3)
            (VarL f.1)
            (VarL v.1)
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
          ((RegL Rbx) ((VarL v.1)))
          ((RegL Rcx)
           ((VarL $ea.2)
            (VarL $ea.3)
            (VarL f.1)
            (VarL v.1)
            (RegL Rsp)
            (RegL Rax)
            (RegL R15)))
          ((RegL Rdx)
           ((VarL $ea.2)
            (VarL $ea.3)
            (VarL f.1)
            (VarL v.1)
            (RegL Rsp)
            (RegL Rax)
            (RegL R15)))
          ((RegL Rsi)
           ((VarL $ea.2)
            (VarL $ea.3)
            (VarL f.1)
            (VarL v.1)
            (RegL Rsp)
            (RegL Rax)
            (RegL Rdi)
            (RegL R15)))
          ((RegL Rdi)
           ((VarL $ea.2)
            (VarL $ea.3)
            (VarL f.1)
            (VarL v.1)
            (RegL Rsp)
            (RegL Rax)
            (RegL Rsi)
            (RegL R15)))
          ((RegL R8)
           ((VarL $ea.2)
            (VarL $ea.3)
            (VarL f.1)
            (VarL v.1)
            (RegL Rsp)
            (RegL Rax)
            (RegL R15)))
          ((RegL R9)
           ((VarL $ea.2)
            (VarL $ea.3)
            (VarL f.1)
            (VarL v.1)
            (RegL Rsp)
            (RegL Rax)
            (RegL R15)))
          ((RegL R10)
           ((VarL $ea.2)
            (VarL $ea.3)
            (VarL f.1)
            (VarL v.1)
            (RegL Rsp)
            (RegL Rax)
            (RegL R15)))
          ((RegL R11)
           ((VarL $ea.2)
            (VarL $ea.3)
            (VarL $ea.4)
            (VarL f.1)
            (VarL v.1)
            (RegL Rsp)
            (RegL Rax)
            (RegL R15)))
          ((RegL R12) ((VarL v.1)))
          ((RegL R13) ((VarL v.1)))
          ((RegL R14) ((VarL v.1)))
          ((RegL R15)
           ((VarL $ea.2)
            (VarL $ea.3)
            (VarL $tmp.10)
            (VarL $tmp.11)
            (VarL $tmp.7)
            (VarL $tmp.8)
            (VarL $tmp.9)
            (VarL f.1)
            (VarL v.1)
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
           ((VarL $ea.2)
            (VarL $ea.3)
            (RegL Rsp)
            (RegL R15))))))
     ((nparams 2)
      (locals
        ((f.1 (Function (Integer) Integer))
         (v.1 (Vector (Integer Integer)))
         ($ea.2 Integer)
         ($ea.3 Integer)
         ($ea.4 (Vector (Integer Integer)))
         ($tmp.10 Integer)
         ($tmp.11 Integer)
         ($tmp.7 Integer)
         ($tmp.8 Integer)
         ($tmp.9 Integer)
         (_.4 Unit)
         (_.5 Unit)
         (_.6 Unit)
         (f.1 (Function (Integer) Integer))
         (v.1 (Vector (Integer Integer)))))
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
             (Movq (Reg R11) (Var $ea.4))
             (Movq (Var $ea.4) (Reg R11))
             (Movq (Var $ea.2) (Deref R11 8))
             (Movq (Imm 0) (Var _.5))
             (Movq (Var $ea.4) (Reg R11))
             (Movq (Var $ea.3) (Deref R11 16))
             (Movq (Imm 0) (Var _.4))
             (Movq (Var $ea.4) (Reg Rax))
             (Jmp (Label map_vec_conclusion)))))
         ((Label block_5)
          (Block
            Binfo1
            ((Movq (Imm 0) (Var _.6))
             (Jmp (Label block_4)))))
         ((Label block_6)
          (Block
            Binfo1
            ((Movq (Reg R15) (Reg Rdi))
             (Movq (Imm 24) (Reg Rsi))
             (Callq (Label collect) 2)
             (Jmp (Label block_4)))))
         ((Label map_vec_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var f.1))
             (Movq (Reg Rsi) (Var v.1))
             (Movq (Var v.1) (Reg R11))
             (Movq (Deref R11 8) (Var $tmp.7))
             (Movq (Var $tmp.7) (Reg Rdi))
             (IndirectCallq (Var f.1) 1)
             (Movq (Reg Rax) (Var $ea.2))
             (Movq (Var v.1) (Reg R11))
             (Movq (Deref R11 16) (Var $tmp.8))
             (Movq (Var $tmp.8) (Reg Rdi))
             (IndirectCallq (Var f.1) 1)
             (Movq (Reg Rax) (Var $ea.3))
             (Movq
               (GlobalArg (Label free_ptr))
               (Var $tmp.9))
             (Movq (Var $tmp.9) (Var $tmp.10))
             (Addq (Imm 24) (Var $tmp.10))
             (Movq
               (GlobalArg (Label fromspace_end))
               (Var $tmp.11))
             (Cmpq (Var $tmp.11) (Var $tmp.10))
             (JmpIf CC_l (Label block_5))
             (Jmp (Label block_6)))))))))
   (Def
     (Label add1)
     (Finfo2
       (conflicts
         (((VarL x.1) ((RegL Rsp)))
          ((RegL Rsp) ((VarL x.1) (RegL Rax)))
          ((RegL Rax) ((RegL Rsp))))))
     ((nparams 1)
      (locals ((x.1 Integer) (x.1 Integer)))
      (body
        (((Label add1_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x.1))
             (Movq (Var x.1) (Reg Rax))
             (Addq (Imm 1) (Reg Rax))
             (Jmp (Label add1_conclusion)))))))))))
