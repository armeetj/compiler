(X86Program
  ((Def
     (Label main)
     (Finfo2
       (conflicts
         (((VarL $tmp.1) ((RegL Rsp) (RegL Rdi)))
          ((VarL apply_1) ((RegL Rsp)))
          ((VarL even) ((RegL Rsp)))
          ((RegL Rsp)
           ((VarL $tmp.1)
            (VarL apply_1)
            (VarL even)
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
        (($tmp.1 (Function (Integer) Boolean))
         (apply_1 Boolean)
         (even (Function (Integer) Boolean))))
      (body
        (((Label block_1)
          (Block
            Binfo1
            ((Movq (Imm 42) (Reg Rax))
             (Jmp (Label main_conclusion)))))
         ((Label block_2)
          (Block
            Binfo1
            ((Movq (Imm 0) (Reg Rax))
             (Jmp (Label main_conclusion)))))
         ((Label main_start)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label even))
               (Var $tmp.1))
             (Movq (Imm 2) (Reg Rdi))
             (IndirectCallq (Var $tmp.1) 1)
             (Movq (Reg Rax) (Var apply_1))
             (Cmpq (Imm 1) (Var apply_1))
             (JmpIf CC_e (Label block_1))
             (Jmp (Label block_2)))))))))
   (Def
     (Label even)
     (Finfo2
       (conflicts
         (((VarL $tmp.2)
           ((VarL $tmp.3) (VarL $tmp.4) (VarL x.1)))
          ((VarL $tmp.3)
           ((VarL $tmp.2) (VarL $tmp.4)))
          ((VarL $tmp.4)
           ((VarL $tmp.2)
            (VarL $tmp.3)
            (VarL x.1)
            (RegL Rdi)))
          ((VarL odd) ((RegL Rsp)))
          ((VarL x.1)
           ((VarL $tmp.2)
            (VarL $tmp.4)
            (RegL Rsp)
            (RegL Rflags)))
          ((RegL Rsp)
           ((VarL odd)
            (VarL x.1)
            (RegL Rax)
            (RegL Rflags)))
          ((RegL Rax) ((RegL Rsp)))
          ((RegL Rdi) ((VarL $tmp.4)))
          ((RegL Rflags) ((VarL x.1) (RegL Rsp))))))
     ((nparams 1)
      (locals
        ((x.1 Integer)
         ($tmp.2 Integer)
         ($tmp.3 Integer)
         ($tmp.4 (Function (Integer) Boolean))
         (odd (Function (Integer) Boolean))
         (x.1 Integer)))
      (body
        (((Label block_3)
          (Block
            Binfo1
            ((Movq (Imm 1) (Reg Rax))
             (Jmp (Label even_conclusion)))))
         ((Label block_4)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label odd))
               (Var $tmp.4))
             (Movq (Imm 1) (Var $tmp.2))
             (Negq (Var $tmp.2))
             (Movq (Var x.1) (Var $tmp.3))
             (Addq (Var $tmp.2) (Var $tmp.3))
             (Movq (Var $tmp.3) (Reg Rdi))
             (TailJmp (Var $tmp.4) 1))))
         ((Label even_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x.1))
             (Cmpq (Imm 0) (Var x.1))
             (JmpIf CC_e (Label block_3))
             (Jmp (Label block_4)))))))))
   (Def
     (Label odd)
     (Finfo2
       (conflicts
         (((VarL $tmp.5)
           ((VarL $tmp.6) (VarL $tmp.7) (VarL x.2)))
          ((VarL $tmp.6)
           ((VarL $tmp.5) (VarL $tmp.7)))
          ((VarL $tmp.7)
           ((VarL $tmp.5)
            (VarL $tmp.6)
            (VarL x.2)
            (RegL Rdi)))
          ((VarL even) ((RegL Rsp)))
          ((VarL x.2)
           ((VarL $tmp.5)
            (VarL $tmp.7)
            (RegL Rsp)
            (RegL Rflags)))
          ((RegL Rsp)
           ((VarL even)
            (VarL x.2)
            (RegL Rax)
            (RegL Rflags)))
          ((RegL Rax) ((RegL Rsp)))
          ((RegL Rdi) ((VarL $tmp.7)))
          ((RegL Rflags) ((VarL x.2) (RegL Rsp))))))
     ((nparams 1)
      (locals
        ((x.2 Integer)
         ($tmp.5 Integer)
         ($tmp.6 Integer)
         ($tmp.7 (Function (Integer) Boolean))
         (even (Function (Integer) Boolean))
         (x.2 Integer)))
      (body
        (((Label block_5)
          (Block
            Binfo1
            ((Movq (Imm 0) (Reg Rax))
             (Jmp (Label odd_conclusion)))))
         ((Label block_6)
          (Block
            Binfo1
            ((Leaq
               (GlobalArg (Label even))
               (Var $tmp.7))
             (Movq (Imm 1) (Var $tmp.5))
             (Negq (Var $tmp.5))
             (Movq (Var x.2) (Var $tmp.6))
             (Addq (Var $tmp.5) (Var $tmp.6))
             (Movq (Var $tmp.6) (Reg Rdi))
             (TailJmp (Var $tmp.7) 1))))
         ((Label odd_start)
          (Block
            Binfo1
            ((Movq (Reg Rdi) (Var x.2))
             (Cmpq (Imm 0) (Var x.2))
             (JmpIf CC_e (Label block_5))
             (Jmp (Label block_6)))))))))))