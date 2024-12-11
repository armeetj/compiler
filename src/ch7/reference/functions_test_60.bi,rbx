(X86Program
  ((Def
     (Label main)
     (Finfo2
       (conflicts
         (((VarL $ea.1)
           ((VarL $tmp.4) (VarL _.1) (RegL R11)))
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
          ((VarL _.2) ((VarL $tmp.4)))
          ((VarL f) ((RegL Rsp)))
          ((RegL Rsp) ((VarL f)))
          ((RegL Rax) ((VarL $tmp.4)))
          ((RegL Rcx) ((VarL $tmp.4)))
          ((RegL Rdx) ((VarL $tmp.4)))
          ((RegL Rsi) ((VarL $tmp.4) (RegL Rdi)))
          ((RegL Rdi) ((VarL $tmp.4) (RegL Rsi)))
          ((RegL R8) ((VarL $tmp.4)))
          ((RegL R9) ((VarL $tmp.4)))
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
        (($ea.1 (Vector (Integer)))
         ($tmp.1 Integer)
         ($tmp.2 Integer)
         ($tmp.3 Integer)
         ($tmp.4
           (Function ((Vector (Integer))) Integer))
         (_.1 Unit)
         (_.2 Unit)
         (f
           (Function ((Vector (Integer))) Integer))))
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
             (Movq (Reg R11) (Var $ea.1))
             (Movq (Var $ea.1) (Reg R11))
             (Movq (Imm 42) (Deref R11 8))
             (Movq (Imm 0) (Var _.1))
             (Movq (Var $ea.1) (Reg Rdi))
             (TailJmp (Var $tmp.4) 1))))
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
         ((Label main_start)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label f))
               (Var $tmp.4))
             (Movq
               (GlobalArg (Label free_ptr))
               (Var $tmp.1))
             (Movq (Var $tmp.1) (Var $tmp.2))
             (Addq (Imm 16) (Var $tmp.2))
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
         (((VarL v.1) ((RegL Rsp)))
          ((RegL Rsp)
           ((VarL v.1) (RegL Rax) (RegL R11)))
          ((RegL Rax) ((RegL Rsp)))
          ((RegL R11) ((RegL Rsp))))))
     ((nparams 1)
      (locals
        ((v.1 (Vector (Integer)))
         (v.1 (Vector (Integer)))))
      (body
        (((Label f_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var v.1))
             (Movq (Var v.1) (Reg R11))
             (Movq (Deref R11 8) (Reg Rax))
             (Jmp (Label f_conclusion)))))))))))
